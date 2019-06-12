package ca.maple.swan.swift.client;

import ca.maple.swan.swift.ipa.callgraph.SwiftAnalysisOptions;
import ca.maple.swan.swift.ipa.callgraph.SwiftEntryPoints;
import ca.maple.swan.swift.ipa.callgraph.SwiftSSAPropagationCallGraphBuilder;
import ca.maple.swan.swift.ir.SwiftLanguage;
import ca.maple.swan.swift.loader.SwiftLoaderFactory;
import ca.maple.swan.swift.translator.SwiftToCAstTranslatorFactory;
import ca.maple.swan.swift.translator.SwiftTranslatorFactory;
import ca.maple.swan.swift.types.SwiftTypes;
import com.ibm.wala.cast.ipa.callgraph.AstCFAPointerKeys;
import com.ibm.wala.cast.ipa.callgraph.AstContextInsensitiveSSAContextInterpreter;
import com.ibm.wala.cast.ipa.callgraph.CAstAnalysisScope;
import com.ibm.wala.cast.ir.ssa.AstIRFactory;
import com.ibm.wala.cast.types.AstMethodReference;
import com.ibm.wala.cast.util.Util;
import com.ibm.wala.classLoader.*;
import com.ibm.wala.classLoader.Module;
import com.ibm.wala.client.AbstractAnalysisEngine;
import com.ibm.wala.ipa.callgraph.*;
import com.ibm.wala.ipa.callgraph.impl.ClassHierarchyClassTargetSelector;
import com.ibm.wala.ipa.callgraph.impl.ClassHierarchyMethodTargetSelector;
import com.ibm.wala.ipa.callgraph.impl.ContextInsensitiveSelector;
import com.ibm.wala.ipa.callgraph.impl.DefaultEntrypoint;
import com.ibm.wala.ipa.callgraph.propagation.InstanceKey;
import com.ibm.wala.ipa.callgraph.propagation.cfa.nCFAContextSelector;
import com.ibm.wala.ipa.cha.*;
import com.ibm.wala.ssa.SSAOptions;
import com.ibm.wala.ssa.SymbolTable;
import com.ibm.wala.ssa.IRFactory;
import com.ibm.wala.types.ClassLoaderReference;
import com.ibm.wala.types.MethodReference;
import com.ibm.wala.types.TypeName;
import com.ibm.wala.types.TypeReference;
import com.ibm.wala.util.WalaException;
import com.ibm.wala.util.WalaRuntimeException;
import com.ibm.wala.util.collections.HashSetFactory;
import com.ibm.wala.util.debug.Assertions;

import java.util.Collections;
import java.util.Set;
import java.util.jar.JarFile;

import static com.ibm.wala.ipa.callgraph.impl.Util.makeMainEntrypoints;

public class SwiftAnalysisEngine<T>
        extends AbstractAnalysisEngine<InstanceKey, SwiftSSAPropagationCallGraphBuilder, T> {

    private final SwiftTranslatorFactory translatorFactory;
    private final SwiftLoaderFactory loaderFactory;
    private final IRFactory<IMethod> irs = AstIRFactory.makeDefaultFactory();

    public SwiftAnalysisEngine() {
        super();
        translatorFactory = new SwiftToCAstTranslatorFactory();
        loaderFactory = new SwiftLoaderFactory(translatorFactory);
    }

    @Override
    public void buildAnalysisScope() {
        SourceModule[] files = moduleFiles.toArray(new SourceModule[0]);
        scope = new CAstAnalysisScope(files, loaderFactory, Collections.singleton(SwiftLanguage.Swift));
    }

    @Override
    public IClassHierarchy buildClassHierarchy() {
        try {
            IClassHierarchy cha = ClassHierarchyFactory.make(scope, loaderFactory, SwiftLanguage.Swift);
            Util.checkForFrontEndErrors(cha);
            setClassHierarchy(cha);
            return cha;
        } catch (ClassHierarchyException e) {
            Assertions.UNREACHABLE(e.toString());
            return null;
        } catch (WalaException e) {
            throw new WalaRuntimeException(e.getMessage());
        }
    }

    @Override
    public void setJ2SELibraries(JarFile[] libs) {
        Assertions.UNREACHABLE("Illegal to call setJ2SELibraries");
    }

    @Override
    public void setJ2SELibraries(Module[] libs) {
        Assertions.UNREACHABLE("Illegal to call setJ2SELibraries");
    }

    private String scriptName(Module m) {
        String path = ((ModuleEntry)m).getName();
        return "LScript " + (path.contains("/")? path.substring(path.lastIndexOf('/')+1): path);
    }

    @Override
    protected Iterable<Entrypoint> makeDefaultEntrypoints(AnalysisScope scope, IClassHierarchy cha) {
        /*
        Set<Entrypoint> result = HashSetFactory.make();
        for(Module m : moduleFiles) {
            IClass entry = cha.lookupClass(TypeReference.findOrCreate(SwiftTypes.swiftLoader, TypeName.findOrCreate(scriptName(m))));
            assert (entry != null) : "bad root name " + scriptName(m) + ":\n" + cha;
            MethodReference er = MethodReference.findOrCreate(entry.getReference(), AstMethodReference.fnSelector);
            result.add(new DefaultEntrypoint(er, cha));
        }
        return result;
         */
        // return makeMainEntrypoints(scope, cha);
        return new SwiftEntryPoints(cha, cha.getLoader(SwiftTypes.swiftLoader));
    }

    @Override
    public IAnalysisCacheView makeDefaultCache() {
        return new AnalysisCacheImpl(AstIRFactory.makeDefaultFactory());
    }

    @Override
    public SwiftAnalysisOptions getDefaultOptions(Iterable<Entrypoint> roots) {
        final SwiftAnalysisOptions options = new SwiftAnalysisOptions(scope, roots);

        options.setUseConstantSpecificKeys(true);

        options.setUseStacksForLexicalScoping(true);

        return options;
    }

    @Override
    protected SwiftSSAPropagationCallGraphBuilder getCallGraphBuilder(IClassHierarchy cha, AnalysisOptions options, IAnalysisCacheView cache2) {
        IAnalysisCacheView cache = new AnalysisCacheImpl(irs, options.getSSAOptions());

        options.setSelector(new ClassHierarchyClassTargetSelector(cha));
        options.setSelector(new ClassHierarchyMethodTargetSelector(cha));

        options.setUseConstantSpecificKeys(true);

        SSAOptions ssaOptions = options.getSSAOptions();
        ssaOptions.setDefaultValues(new SSAOptions.DefaultValues() {
            @Override
            public int getDefaultValue(SymbolTable symtab, int valueNumber) {
                return symtab.getNullConstant();
            }
        });
        options.setSSAOptions(ssaOptions);

        SwiftSSAPropagationCallGraphBuilder builder =
                new SwiftSSAPropagationCallGraphBuilder(cha, options, cache, new AstCFAPointerKeys());

        AstContextInsensitiveSSAContextInterpreter interpreter = new AstContextInsensitiveSSAContextInterpreter(options, cache);
        builder.setContextInterpreter(interpreter);

        builder.setContextSelector(new nCFAContextSelector(1, new ContextInsensitiveSelector()));

        return builder;
    }
}
