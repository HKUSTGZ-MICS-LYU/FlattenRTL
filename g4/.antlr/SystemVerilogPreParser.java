// Generated from /home/ziyue/researchlib/Micro_Eletronic/FlattenRTL_SV/g4/SystemVerilogPreParser.g4 by ANTLR 4.13.1
import org.antlr.v4.runtime.atn.*;
import org.antlr.v4.runtime.dfa.DFA;
import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.misc.*;
import org.antlr.v4.runtime.tree.*;
import java.util.List;
import java.util.Iterator;
import java.util.ArrayList;

@SuppressWarnings({"all", "warnings", "unchecked", "unused", "cast", "CheckReturnValue"})
public class SystemVerilogPreParser extends Parser {
	static { RuntimeMetaData.checkVersion("4.13.1", RuntimeMetaData.VERSION); }

	protected static final DFA[] _decisionToDFA;
	protected static final PredictionContextCache _sharedContextCache =
		new PredictionContextCache();
	public static final int
		ACCEPT_ON=1, ALIAS=2, ALWAYS=3, ALWAYS_COMB=4, ALWAYS_FF=5, ALWAYS_LATCH=6, 
		AND=7, ASSERT=8, ASSIGN=9, ASSUME=10, AUTOMATIC=11, BEFORE=12, BEGIN=13, 
		BIND=14, BINS=15, BINSOF=16, BIT=17, BREAK=18, BUF=19, BUFIFONE=20, BUFIFZERO=21, 
		BYTE=22, CASE=23, CASEX=24, CASEZ=25, CELL=26, CHANDLE=27, CHECKER=28, 
		CLASS=29, CLOCKING=30, CMOS=31, CONFIG=32, CONST=33, CONSTRAINT=34, CONTEXT=35, 
		CONTINUE=36, COVER=37, COVERGROUP=38, COVERPOINT=39, CROSS=40, DEASSIGN=41, 
		DEFAULT=42, DEFPARAM=43, DESIGN=44, DISABLE=45, DIST=46, DLERROR=47, DLFATAL=48, 
		DLFULLSKEW=49, DLHOLD=50, DLINFO=51, DLNOCHANGE=52, DLPERIOD=53, DLRECOVERY=54, 
		DLRECREM=55, DLREMOVAL=56, DLROOT=57, DLSETUP=58, DLSETUPHOLD=59, DLSKEW=60, 
		DLTIMESKEW=61, DLUNIT=62, DLWARNING=63, DLWIDTH=64, DO=65, DQDPIDQ=66, 
		DQDPIMICDQ=67, EDGE=68, ELSE=69, END=70, ENDCASE=71, ENDCHECKER=72, ENDCLASS=73, 
		ENDCLOCKING=74, ENDCONFIG=75, ENDFUNCTION=76, ENDGENERATE=77, ENDGROUP=78, 
		ENDINTERFACE=79, ENDMODULE=80, ENDPACKAGE=81, ENDPRIMITIVE=82, ENDPROGRAM=83, 
		ENDPROPERTY=84, ENDSEQUENCE=85, ENDSPECIFY=86, ENDTABLE=87, ENDTASK=88, 
		ENUM=89, EVENT=90, EVENTUALLY=91, EXPECT=92, EXPORT=93, EXTENDS=94, EXTERN=95, 
		FINAL=96, FIRST_MATCH=97, FOR=98, FORCE=99, FOREACH=100, FOREVER=101, 
		FORK=102, FORKJOIN=103, FUNCTION=104, GENERATE=105, GENVAR=106, GLOBAL=107, 
		HIGHZONE=108, HIGHZZERO=109, IF=110, IFF=111, IFNONE=112, IGNORE_BINS=113, 
		ILLEGAL_BINS=114, IMPLEMENTS=115, IMPLIES=116, IMPORT=117, INCLUDE=118, 
		INITIAL=119, INOUT=120, INPUT=121, INSIDE=122, INSTANCE=123, INT=124, 
		INTEGER=125, INTERCONNECT=126, INTERFACE=127, INTERSECT=128, JOIN=129, 
		JOIN_ANY=130, JOIN_NONE=131, LARGE=132, LET=133, LIBLIST=134, LIBRARY=135, 
		LOCAL=136, LOCALPARAM=137, LOGIC=138, LONGINT=139, MACROMODULE=140, MATCHES=141, 
		MEDIUM=142, MIINCDIR=143, MODPORT=144, MODULE=145, NAND=146, NEGEDGE=147, 
		NETTYPE=148, NEW=149, NEXTTIME=150, NMOS=151, NOR=152, NOSHOWCANCELLED=153, 
		NOT=154, NOTIFONE=155, NOTIFZERO=156, NULL=157, ONESTEP=158, OPTION=159, 
		OR=160, OUTPUT=161, PACKAGE=162, PACKED=163, PARAMETER=164, PATHPULSEDL=165, 
		PMOS=166, POSEDGE=167, PRIMITIVE=168, PRIORITY=169, PROGRAM=170, PROPERTY=171, 
		PROTECTED=172, PULLDOWN=173, PULLONE=174, PULLUP=175, PULLZERO=176, PULSESTYLE_ONDETECT=177, 
		PULSESTYLE_ONEVENT=178, PURE=179, RAND=180, RANDC=181, RANDCASE=182, RANDOMIZE=183, 
		RANDSEQUENCE=184, RCMOS=185, REAL=186, REALTIME=187, REF=188, REG=189, 
		REJECT_ON=190, RELEASE=191, REPEAT=192, RESTRICT=193, RETURN=194, RNMOS=195, 
		RPMOS=196, RTRAN=197, RTRANIFONE=198, RTRANIFZERO=199, S_ALWAYS=200, S_EVENTUALLY=201, 
		S_NEXTTIME=202, S_UNTIL=203, S_UNTIL_WITH=204, SAMPLE=205, SCALARED=206, 
		SEQUENCE=207, SHORTINT=208, SHORTREAL=209, SHOWCANCELLED=210, SIGNED=211, 
		SMALL=212, SOFT=213, SOLVE=214, SPECIFY=215, SPECPARAM=216, STATIC=217, 
		STD=218, STRING=219, STRONG=220, STRONGONE=221, STRONGZERO=222, STRUCT=223, 
		SUPER=224, SUPPLYONE=225, SUPPLYZERO=226, SYNC_ACCEPT_ON=227, SYNC_REJECT_ON=228, 
		TABLE=229, TAGGED=230, TASK=231, THIS=232, THROUGHOUT=233, TIME=234, TIMEPRECISION=235, 
		TIMEUNIT=236, TRAN=237, TRANIFONE=238, TRANIFZERO=239, TRI=240, TRIAND=241, 
		TRIONE=242, TRIOR=243, TRIREG=244, TRIZERO=245, TYPE=246, TYPE_OPTION=247, 
		TYPEDEF=248, UNION=249, UNIQUE=250, UNIQUEZERO=251, UNSIGNED=252, UNTIL=253, 
		UNTIL_WITH=254, UNTYPED=255, USE=256, UWIRE=257, VAR=258, VECTORED=259, 
		VIRTUAL=260, VOID=261, WAIT=262, WAIT_ORDER=263, WAND=264, WEAK=265, WEAKONE=266, 
		WEAKZERO=267, WHILE=268, WILDCARD=269, WIRE=270, WITH=271, WITHIN=272, 
		WOR=273, XNOR=274, XOR=275, AM=276, AMAM=277, AMAMAM=278, AMEQ=279, AP=280, 
		AS=281, ASAS=282, ASEQ=283, ASGT=284, AT=285, ATAT=286, CA=287, CAEQ=288, 
		CATI=289, CL=290, CLCL=291, CLEQ=292, CLSL=293, CO=294, DL=295, DQ=296, 
		DT=297, DTAS=298, EM=299, EMEQ=300, EMEQEQ=301, EMEQQM=302, EQ=303, EQEQ=304, 
		EQEQEQ=305, EQEQQM=306, EQGT=307, GA=308, GT=309, GTEQ=310, GTGT=311, 
		GTGTEQ=312, GTGTGT=313, GTGTGTEQ=314, HA=315, HAEQHA=316, HAHA=317, HAMIHA=318, 
		LB=319, LC=320, LP=321, LT=322, LTEQ=323, LTLT=324, LTLTEQ=325, LTLTLT=326, 
		LTLTLTEQ=327, LTMIGT=328, MI=329, MICL=330, MIEQ=331, MIGT=332, MIGTGT=333, 
		MIMI=334, MO=335, MOEQ=336, PL=337, PLCL=338, PLEQ=339, PLPL=340, QM=341, 
		RB=342, RC=343, RP=344, SC=345, SL=346, SLEQ=347, TI=348, TIAM=349, TICA=350, 
		TIVL=351, VL=352, VLEQ=353, VLEQGT=354, VLMIGT=355, VLVL=356, BINARY_BASE=357, 
		BLOCK_COMMENT=358, DECIMAL_BASE=359, ESCAPED_IDENTIFIER=360, EXPONENTIAL_NUMBER=361, 
		FIXED_POINT_NUMBER=362, HEX_BASE=363, LINE_COMMENT=364, OCTAL_BASE=365, 
		SIMPLE_IDENTIFIER=366, STRING_LITERAL=367, SYSTEM_TF_IDENTIFIER=368, TIME_LITERAL=369, 
		UNBASED_UNSIZED_LITERAL=370, UNSIGNED_NUMBER=371, WHITE_SPACE=372, ZERO_OR_ONE_X_OR_Z=373, 
		BINARY_VALUE=374, X_OR_Z_UNDERSCORE=375, HEX_VALUE=376, FILE_PATH_SPEC=377, 
		OCTAL_VALUE=378, EDGE_SYMBOL=379, LEVEL_ONLY_SYMBOL=380, OUTPUT_OR_LEVEL_SYMBOL=381, 
		BEGIN_KEYWORDS_DIRECTIVE=382, CELLDEFINE_DIRECTIVE=383, DEFAULT_NETTYPE_DIRECTIVE=384, 
		DEFINE_DIRECTIVE=385, ELSE_DIRECTIVE=386, ELSIF_DIRECTIVE=387, END_KEYWORDS_DIRECTIVE=388, 
		ENDCELLDEFINE_DIRECTIVE=389, ENDIF_DIRECTIVE=390, FILE_DIRECTIVE=391, 
		IFDEF_DIRECTIVE=392, IFNDEF_DIRECTIVE=393, INCLUDE_DIRECTIVE=394, LINE_DIRECTIVE=395, 
		LINE_DIRECTIVE_=396, NOUNCONNECTED_DRIVE_DIRECTIVE=397, PRAGMA_DIRECTIVE=398, 
		RESETALL_DIRECTIVE=399, TIMESCALE_DIRECTIVE=400, UNCONNECTED_DRIVE_DIRECTIVE=401, 
		UNDEF_DIRECTIVE=402, UNDEFINEALL_DIRECTIVE=403, MACRO_USAGE=404, VERSION_SPECIFIER=405, 
		DEFAULT_NETTYPE_VALUE=406, MACRO_NAME=407, FILENAME=408, MACRO_DELIMITER=409, 
		MACRO_ESC_NEWLINE=410, MACRO_ESC_QUOTE=411, MACRO_QUOTE=412, MACRO_TEXT=413, 
		SOURCE_TEXT=414, TIME_UNIT=415, TIME_VALUE=416, UNCONNECTED_DRIVE_VALUE=417, 
		MACRO_IDENTIFIER=418;
	public static final int
		RULE_source_text = 0, RULE_compiler_directive = 1, RULE_begin_keywords_directive = 2, 
		RULE_celldefine_directive = 3, RULE_default_nettype_directive = 4, RULE_default_nettype_value = 5, 
		RULE_else_directive = 6, RULE_elsif_directive = 7, RULE_end_keywords_directive = 8, 
		RULE_endcelldefine_directive = 9, RULE_endif_directive = 10, RULE_file_directive = 11, 
		RULE_filename = 12, RULE_group_of_lines = 13, RULE_identifier = 14, RULE_ifdef_directive = 15, 
		RULE_ifndef_directive = 16, RULE_include_directive = 17, RULE_level = 18, 
		RULE_line_directive = 19, RULE_line_directive_ = 20, RULE_macro_delimiter = 21, 
		RULE_macro_esc_newline = 22, RULE_macro_esc_quote = 23, RULE_macro_identifier = 24, 
		RULE_macro_name = 25, RULE_macro_quote = 26, RULE_macro_text = 27, RULE_macro_text_ = 28, 
		RULE_macro_usage = 29, RULE_nounconnected_drive_directive = 30, RULE_number = 31, 
		RULE_pragma_directive = 32, RULE_pragma_expression = 33, RULE_pragma_keyword = 34, 
		RULE_pragma_name = 35, RULE_pragma_value = 36, RULE_resetall_directive = 37, 
		RULE_source_text_ = 38, RULE_string_literal = 39, RULE_text_macro_definition = 40, 
		RULE_text_macro_usage = 41, RULE_time_precision = 42, RULE_time_unit = 43, 
		RULE_timescale_directive = 44, RULE_unconnected_drive_directive = 45, 
		RULE_unconnected_drive_value = 46, RULE_undef_directive = 47, RULE_undefineall_directive = 48, 
		RULE_version_specifier = 49;
	private static String[] makeRuleNames() {
		return new String[] {
			"source_text", "compiler_directive", "begin_keywords_directive", "celldefine_directive", 
			"default_nettype_directive", "default_nettype_value", "else_directive", 
			"elsif_directive", "end_keywords_directive", "endcelldefine_directive", 
			"endif_directive", "file_directive", "filename", "group_of_lines", "identifier", 
			"ifdef_directive", "ifndef_directive", "include_directive", "level", 
			"line_directive", "line_directive_", "macro_delimiter", "macro_esc_newline", 
			"macro_esc_quote", "macro_identifier", "macro_name", "macro_quote", "macro_text", 
			"macro_text_", "macro_usage", "nounconnected_drive_directive", "number", 
			"pragma_directive", "pragma_expression", "pragma_keyword", "pragma_name", 
			"pragma_value", "resetall_directive", "source_text_", "string_literal", 
			"text_macro_definition", "text_macro_usage", "time_precision", "time_unit", 
			"timescale_directive", "unconnected_drive_directive", "unconnected_drive_value", 
			"undef_directive", "undefineall_directive", "version_specifier"
		};
	}
	public static final String[] ruleNames = makeRuleNames();

	private static String[] makeLiteralNames() {
		return new String[] {
			null, "'accept_on'", "'alias'", "'always'", "'always_comb'", "'always_ff'", 
			"'always_latch'", "'and'", "'assert'", "'assign'", "'assume'", "'automatic'", 
			"'before'", "'begin'", "'bind'", "'bins'", "'binsof'", "'bit'", "'break'", 
			"'buf'", "'bufif1'", "'bufif0'", "'byte'", "'case'", "'casex'", "'casez'", 
			"'cell'", "'chandle'", "'checker'", "'class'", "'clocking'", "'cmos'", 
			"'config'", "'const'", "'constraint'", "'context'", "'continue'", "'cover'", 
			"'covergroup'", "'coverpoint'", "'cross'", "'deassign'", "'default'", 
			"'defparam'", "'design'", "'disable'", "'dist'", "'$error'", "'$fatal'", 
			"'$fullskew'", "'$hold'", "'$info'", "'$nochange'", "'$period'", "'$recovery'", 
			"'$recrem'", "'$removal'", "'$root'", "'$setup'", "'$setuphold'", "'$skew'", 
			"'$timeskew'", "'$unit'", "'$warning'", "'$width'", "'do'", "'\"DPI\"'", 
			"'\"DPI-C\"'", "'edge'", "'else'", "'end'", "'endcase'", "'endchecker'", 
			"'endclass'", "'endclocking'", "'endconfig'", "'endfunction'", "'endgenerate'", 
			"'endgroup'", "'endinterface'", "'endmodule'", "'endpackage'", "'endprimitive'", 
			"'endprogram'", "'endproperty'", "'endsequence'", "'endspecify'", "'endtable'", 
			"'endtask'", "'enum'", "'event'", "'eventually'", "'expect'", "'export'", 
			"'extends'", "'extern'", "'final'", "'first_match'", "'for'", "'force'", 
			"'foreach'", "'forever'", "'fork'", "'forkjoin'", "'function'", "'generate'", 
			"'genvar'", "'global'", "'highz1'", "'highz0'", "'if'", "'iff'", "'ifnone'", 
			"'ignore_bins'", "'illegal_bins'", "'implements'", "'implies'", "'import'", 
			"'include'", "'initial'", "'inout'", "'input'", "'inside'", "'instance'", 
			"'int'", "'integer'", "'interconnect'", "'interface'", "'intersect'", 
			"'join'", "'join_any'", "'join_none'", "'large'", "'let'", "'liblist'", 
			"'library'", "'local'", "'localparam'", "'logic'", "'longint'", "'macromodule'", 
			"'matches'", "'medium'", "'-incdir'", "'modport'", "'module'", "'nand'", 
			"'negedge'", "'nettype'", "'new'", "'nexttime'", "'nmos'", "'nor'", "'noshowcancelled'", 
			"'not'", "'notif1'", "'notif0'", "'null'", "'1step'", "'option'", "'or'", 
			"'output'", "'package'", "'packed'", "'parameter'", "'PATHPULSE$'", "'pmos'", 
			"'posedge'", "'primitive'", "'priority'", "'program'", "'property'", 
			"'protected'", "'pulldown'", "'pull1'", "'pullup'", "'pull0'", "'pulsestyle_ondetect'", 
			"'pulsestyle_onevent'", "'pure'", "'rand'", "'randc'", "'randcase'", 
			"'randomize'", "'randsequence'", "'rcmos'", "'real'", "'realtime'", "'ref'", 
			"'reg'", "'reject_on'", "'release'", "'repeat'", "'restrict'", "'return'", 
			"'rnmos'", "'rpmos'", "'rtran'", "'rtranif1'", "'rtranif0'", "'s_always'", 
			"'s_eventually'", "'s_nexttime'", "'s_until'", "'s_until_with'", "'sample'", 
			"'scalared'", "'sequence'", "'shortint'", "'shortreal'", "'showcancelled'", 
			"'signed'", "'small'", "'soft'", "'solve'", "'specify'", "'specparam'", 
			"'static'", "'std'", "'string'", "'strong'", "'strong1'", "'strong0'", 
			"'struct'", "'super'", "'supply1'", "'supply0'", "'sync_accept_on'", 
			"'sync_reject_on'", "'table'", "'tagged'", "'task'", "'this'", "'throughout'", 
			"'time'", "'timeprecision'", "'timeunit'", "'tran'", "'tranif1'", "'tranif0'", 
			"'tri'", "'triand'", "'tri1'", "'trior'", "'trireg'", "'tri0'", "'type'", 
			"'type_option'", "'typedef'", "'union'", "'unique'", "'unique0'", "'unsigned'", 
			"'until'", "'until_with'", "'untyped'", "'use'", "'uwire'", "'var'", 
			"'vectored'", "'virtual'", "'void'", "'wait'", "'wait_order'", "'wand'", 
			"'weak'", "'weak1'", "'weak0'", "'while'", "'wildcard'", "'wire'", "'with'", 
			"'within'", "'wor'", "'xnor'", "'xor'", "'&'", "'&&'", "'&&&'", "'&='", 
			"'''", "'*'", "'**'", "'*='", "'*>'", "'@'", "'@@'", "'^'", "'^='", "'^~'", 
			"':'", "'::'", "':='", "':/'", "','", "'$'", "'\"'", "'.'", "'.*'", "'!'", 
			"'!='", "'!=='", "'!=?'", "'='", "'=='", "'==='", "'==?'", "'=>'", null, 
			"'>'", "'>='", "'>>'", "'>>='", "'>>>'", "'>>>='", "'#'", "'#=#'", "'##'", 
			"'#-#'", "'['", "'{'", "'('", "'<'", "'<='", "'<<'", "'<<='", "'<<<'", 
			"'<<<='", "'<->'", "'-'", "'-:'", "'-='", "'->'", "'->>'", "'--'", "'%'", 
			"'%='", "'+'", "'+:'", "'+='", "'++'", "'?'", "']'", "'}'", "')'", "';'", 
			"'/'", "'/='", "'~'", "'~&'", "'~^'", "'~|'", "'|'", "'|='", "'|=>'", 
			"'|->'", "'||'", null, null, null, null, null, null, null, null, null, 
			null, null, null, null, null, null, null, null, null, null, null, null, 
			null, null, null, null, null, "'celldefine'", null, null, null, null, 
			"'end_keywords'", "'endcelldefine'", null, "'__FILE__'", null, null, 
			null, null, "'__LINE__'", "'nounconnected_drive'", null, "'resetall'", 
			null, null, null, "'undefineall'", null, null, null, null, null, "'``'", 
			null, "'`\\`\"'", "'`\"'"
		};
	}
	private static final String[] _LITERAL_NAMES = makeLiteralNames();
	private static String[] makeSymbolicNames() {
		return new String[] {
			null, "ACCEPT_ON", "ALIAS", "ALWAYS", "ALWAYS_COMB", "ALWAYS_FF", "ALWAYS_LATCH", 
			"AND", "ASSERT", "ASSIGN", "ASSUME", "AUTOMATIC", "BEFORE", "BEGIN", 
			"BIND", "BINS", "BINSOF", "BIT", "BREAK", "BUF", "BUFIFONE", "BUFIFZERO", 
			"BYTE", "CASE", "CASEX", "CASEZ", "CELL", "CHANDLE", "CHECKER", "CLASS", 
			"CLOCKING", "CMOS", "CONFIG", "CONST", "CONSTRAINT", "CONTEXT", "CONTINUE", 
			"COVER", "COVERGROUP", "COVERPOINT", "CROSS", "DEASSIGN", "DEFAULT", 
			"DEFPARAM", "DESIGN", "DISABLE", "DIST", "DLERROR", "DLFATAL", "DLFULLSKEW", 
			"DLHOLD", "DLINFO", "DLNOCHANGE", "DLPERIOD", "DLRECOVERY", "DLRECREM", 
			"DLREMOVAL", "DLROOT", "DLSETUP", "DLSETUPHOLD", "DLSKEW", "DLTIMESKEW", 
			"DLUNIT", "DLWARNING", "DLWIDTH", "DO", "DQDPIDQ", "DQDPIMICDQ", "EDGE", 
			"ELSE", "END", "ENDCASE", "ENDCHECKER", "ENDCLASS", "ENDCLOCKING", "ENDCONFIG", 
			"ENDFUNCTION", "ENDGENERATE", "ENDGROUP", "ENDINTERFACE", "ENDMODULE", 
			"ENDPACKAGE", "ENDPRIMITIVE", "ENDPROGRAM", "ENDPROPERTY", "ENDSEQUENCE", 
			"ENDSPECIFY", "ENDTABLE", "ENDTASK", "ENUM", "EVENT", "EVENTUALLY", "EXPECT", 
			"EXPORT", "EXTENDS", "EXTERN", "FINAL", "FIRST_MATCH", "FOR", "FORCE", 
			"FOREACH", "FOREVER", "FORK", "FORKJOIN", "FUNCTION", "GENERATE", "GENVAR", 
			"GLOBAL", "HIGHZONE", "HIGHZZERO", "IF", "IFF", "IFNONE", "IGNORE_BINS", 
			"ILLEGAL_BINS", "IMPLEMENTS", "IMPLIES", "IMPORT", "INCLUDE", "INITIAL", 
			"INOUT", "INPUT", "INSIDE", "INSTANCE", "INT", "INTEGER", "INTERCONNECT", 
			"INTERFACE", "INTERSECT", "JOIN", "JOIN_ANY", "JOIN_NONE", "LARGE", "LET", 
			"LIBLIST", "LIBRARY", "LOCAL", "LOCALPARAM", "LOGIC", "LONGINT", "MACROMODULE", 
			"MATCHES", "MEDIUM", "MIINCDIR", "MODPORT", "MODULE", "NAND", "NEGEDGE", 
			"NETTYPE", "NEW", "NEXTTIME", "NMOS", "NOR", "NOSHOWCANCELLED", "NOT", 
			"NOTIFONE", "NOTIFZERO", "NULL", "ONESTEP", "OPTION", "OR", "OUTPUT", 
			"PACKAGE", "PACKED", "PARAMETER", "PATHPULSEDL", "PMOS", "POSEDGE", "PRIMITIVE", 
			"PRIORITY", "PROGRAM", "PROPERTY", "PROTECTED", "PULLDOWN", "PULLONE", 
			"PULLUP", "PULLZERO", "PULSESTYLE_ONDETECT", "PULSESTYLE_ONEVENT", "PURE", 
			"RAND", "RANDC", "RANDCASE", "RANDOMIZE", "RANDSEQUENCE", "RCMOS", "REAL", 
			"REALTIME", "REF", "REG", "REJECT_ON", "RELEASE", "REPEAT", "RESTRICT", 
			"RETURN", "RNMOS", "RPMOS", "RTRAN", "RTRANIFONE", "RTRANIFZERO", "S_ALWAYS", 
			"S_EVENTUALLY", "S_NEXTTIME", "S_UNTIL", "S_UNTIL_WITH", "SAMPLE", "SCALARED", 
			"SEQUENCE", "SHORTINT", "SHORTREAL", "SHOWCANCELLED", "SIGNED", "SMALL", 
			"SOFT", "SOLVE", "SPECIFY", "SPECPARAM", "STATIC", "STD", "STRING", "STRONG", 
			"STRONGONE", "STRONGZERO", "STRUCT", "SUPER", "SUPPLYONE", "SUPPLYZERO", 
			"SYNC_ACCEPT_ON", "SYNC_REJECT_ON", "TABLE", "TAGGED", "TASK", "THIS", 
			"THROUGHOUT", "TIME", "TIMEPRECISION", "TIMEUNIT", "TRAN", "TRANIFONE", 
			"TRANIFZERO", "TRI", "TRIAND", "TRIONE", "TRIOR", "TRIREG", "TRIZERO", 
			"TYPE", "TYPE_OPTION", "TYPEDEF", "UNION", "UNIQUE", "UNIQUEZERO", "UNSIGNED", 
			"UNTIL", "UNTIL_WITH", "UNTYPED", "USE", "UWIRE", "VAR", "VECTORED", 
			"VIRTUAL", "VOID", "WAIT", "WAIT_ORDER", "WAND", "WEAK", "WEAKONE", "WEAKZERO", 
			"WHILE", "WILDCARD", "WIRE", "WITH", "WITHIN", "WOR", "XNOR", "XOR", 
			"AM", "AMAM", "AMAMAM", "AMEQ", "AP", "AS", "ASAS", "ASEQ", "ASGT", "AT", 
			"ATAT", "CA", "CAEQ", "CATI", "CL", "CLCL", "CLEQ", "CLSL", "CO", "DL", 
			"DQ", "DT", "DTAS", "EM", "EMEQ", "EMEQEQ", "EMEQQM", "EQ", "EQEQ", "EQEQEQ", 
			"EQEQQM", "EQGT", "GA", "GT", "GTEQ", "GTGT", "GTGTEQ", "GTGTGT", "GTGTGTEQ", 
			"HA", "HAEQHA", "HAHA", "HAMIHA", "LB", "LC", "LP", "LT", "LTEQ", "LTLT", 
			"LTLTEQ", "LTLTLT", "LTLTLTEQ", "LTMIGT", "MI", "MICL", "MIEQ", "MIGT", 
			"MIGTGT", "MIMI", "MO", "MOEQ", "PL", "PLCL", "PLEQ", "PLPL", "QM", "RB", 
			"RC", "RP", "SC", "SL", "SLEQ", "TI", "TIAM", "TICA", "TIVL", "VL", "VLEQ", 
			"VLEQGT", "VLMIGT", "VLVL", "BINARY_BASE", "BLOCK_COMMENT", "DECIMAL_BASE", 
			"ESCAPED_IDENTIFIER", "EXPONENTIAL_NUMBER", "FIXED_POINT_NUMBER", "HEX_BASE", 
			"LINE_COMMENT", "OCTAL_BASE", "SIMPLE_IDENTIFIER", "STRING_LITERAL", 
			"SYSTEM_TF_IDENTIFIER", "TIME_LITERAL", "UNBASED_UNSIZED_LITERAL", "UNSIGNED_NUMBER", 
			"WHITE_SPACE", "ZERO_OR_ONE_X_OR_Z", "BINARY_VALUE", "X_OR_Z_UNDERSCORE", 
			"HEX_VALUE", "FILE_PATH_SPEC", "OCTAL_VALUE", "EDGE_SYMBOL", "LEVEL_ONLY_SYMBOL", 
			"OUTPUT_OR_LEVEL_SYMBOL", "BEGIN_KEYWORDS_DIRECTIVE", "CELLDEFINE_DIRECTIVE", 
			"DEFAULT_NETTYPE_DIRECTIVE", "DEFINE_DIRECTIVE", "ELSE_DIRECTIVE", "ELSIF_DIRECTIVE", 
			"END_KEYWORDS_DIRECTIVE", "ENDCELLDEFINE_DIRECTIVE", "ENDIF_DIRECTIVE", 
			"FILE_DIRECTIVE", "IFDEF_DIRECTIVE", "IFNDEF_DIRECTIVE", "INCLUDE_DIRECTIVE", 
			"LINE_DIRECTIVE", "LINE_DIRECTIVE_", "NOUNCONNECTED_DRIVE_DIRECTIVE", 
			"PRAGMA_DIRECTIVE", "RESETALL_DIRECTIVE", "TIMESCALE_DIRECTIVE", "UNCONNECTED_DRIVE_DIRECTIVE", 
			"UNDEF_DIRECTIVE", "UNDEFINEALL_DIRECTIVE", "MACRO_USAGE", "VERSION_SPECIFIER", 
			"DEFAULT_NETTYPE_VALUE", "MACRO_NAME", "FILENAME", "MACRO_DELIMITER", 
			"MACRO_ESC_NEWLINE", "MACRO_ESC_QUOTE", "MACRO_QUOTE", "MACRO_TEXT", 
			"SOURCE_TEXT", "TIME_UNIT", "TIME_VALUE", "UNCONNECTED_DRIVE_VALUE", 
			"MACRO_IDENTIFIER"
		};
	}
	private static final String[] _SYMBOLIC_NAMES = makeSymbolicNames();
	public static final Vocabulary VOCABULARY = new VocabularyImpl(_LITERAL_NAMES, _SYMBOLIC_NAMES);

	/**
	 * @deprecated Use {@link #VOCABULARY} instead.
	 */
	@Deprecated
	public static final String[] tokenNames;
	static {
		tokenNames = new String[_SYMBOLIC_NAMES.length];
		for (int i = 0; i < tokenNames.length; i++) {
			tokenNames[i] = VOCABULARY.getLiteralName(i);
			if (tokenNames[i] == null) {
				tokenNames[i] = VOCABULARY.getSymbolicName(i);
			}

			if (tokenNames[i] == null) {
				tokenNames[i] = "<INVALID>";
			}
		}
	}

	@Override
	@Deprecated
	public String[] getTokenNames() {
		return tokenNames;
	}

	@Override

	public Vocabulary getVocabulary() {
		return VOCABULARY;
	}

	@Override
	public String getGrammarFileName() { return "SystemVerilogPreParser.g4"; }

	@Override
	public String[] getRuleNames() { return ruleNames; }

	@Override
	public String getSerializedATN() { return _serializedATN; }

	@Override
	public ATN getATN() { return _ATN; }

	public SystemVerilogPreParser(TokenStream input) {
		super(input);
		_interp = new ParserATNSimulator(this,_ATN,_decisionToDFA,_sharedContextCache);
	}

	@SuppressWarnings("CheckReturnValue")
	public static class Source_textContext extends ParserRuleContext {
		public List<Compiler_directiveContext> compiler_directive() {
			return getRuleContexts(Compiler_directiveContext.class);
		}
		public Compiler_directiveContext compiler_directive(int i) {
			return getRuleContext(Compiler_directiveContext.class,i);
		}
		public Source_textContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_source_text; }
	}

	public final Source_textContext source_text() throws RecognitionException {
		Source_textContext _localctx = new Source_textContext(_ctx, getState());
		enterRule(_localctx, 0, RULE_source_text);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(103);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while (_la==GA) {
				{
				{
				setState(100);
				compiler_directive();
				}
				}
				setState(105);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class Compiler_directiveContext extends ParserRuleContext {
		public Begin_keywords_directiveContext begin_keywords_directive() {
			return getRuleContext(Begin_keywords_directiveContext.class,0);
		}
		public Celldefine_directiveContext celldefine_directive() {
			return getRuleContext(Celldefine_directiveContext.class,0);
		}
		public Default_nettype_directiveContext default_nettype_directive() {
			return getRuleContext(Default_nettype_directiveContext.class,0);
		}
		public End_keywords_directiveContext end_keywords_directive() {
			return getRuleContext(End_keywords_directiveContext.class,0);
		}
		public Endcelldefine_directiveContext endcelldefine_directive() {
			return getRuleContext(Endcelldefine_directiveContext.class,0);
		}
		public File_directiveContext file_directive() {
			return getRuleContext(File_directiveContext.class,0);
		}
		public Ifdef_directiveContext ifdef_directive() {
			return getRuleContext(Ifdef_directiveContext.class,0);
		}
		public Ifndef_directiveContext ifndef_directive() {
			return getRuleContext(Ifndef_directiveContext.class,0);
		}
		public Include_directiveContext include_directive() {
			return getRuleContext(Include_directiveContext.class,0);
		}
		public Line_directiveContext line_directive() {
			return getRuleContext(Line_directiveContext.class,0);
		}
		public Line_directive_Context line_directive_() {
			return getRuleContext(Line_directive_Context.class,0);
		}
		public Nounconnected_drive_directiveContext nounconnected_drive_directive() {
			return getRuleContext(Nounconnected_drive_directiveContext.class,0);
		}
		public Pragma_directiveContext pragma_directive() {
			return getRuleContext(Pragma_directiveContext.class,0);
		}
		public Resetall_directiveContext resetall_directive() {
			return getRuleContext(Resetall_directiveContext.class,0);
		}
		public Text_macro_definitionContext text_macro_definition() {
			return getRuleContext(Text_macro_definitionContext.class,0);
		}
		public Text_macro_usageContext text_macro_usage() {
			return getRuleContext(Text_macro_usageContext.class,0);
		}
		public Timescale_directiveContext timescale_directive() {
			return getRuleContext(Timescale_directiveContext.class,0);
		}
		public Unconnected_drive_directiveContext unconnected_drive_directive() {
			return getRuleContext(Unconnected_drive_directiveContext.class,0);
		}
		public Undef_directiveContext undef_directive() {
			return getRuleContext(Undef_directiveContext.class,0);
		}
		public Undefineall_directiveContext undefineall_directive() {
			return getRuleContext(Undefineall_directiveContext.class,0);
		}
		public Compiler_directiveContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_compiler_directive; }
	}

	public final Compiler_directiveContext compiler_directive() throws RecognitionException {
		Compiler_directiveContext _localctx = new Compiler_directiveContext(_ctx, getState());
		enterRule(_localctx, 2, RULE_compiler_directive);
		try {
			setState(126);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,1,_ctx) ) {
			case 1:
				enterOuterAlt(_localctx, 1);
				{
				setState(106);
				begin_keywords_directive();
				}
				break;
			case 2:
				enterOuterAlt(_localctx, 2);
				{
				setState(107);
				celldefine_directive();
				}
				break;
			case 3:
				enterOuterAlt(_localctx, 3);
				{
				setState(108);
				default_nettype_directive();
				}
				break;
			case 4:
				enterOuterAlt(_localctx, 4);
				{
				setState(109);
				end_keywords_directive();
				}
				break;
			case 5:
				enterOuterAlt(_localctx, 5);
				{
				setState(110);
				endcelldefine_directive();
				}
				break;
			case 6:
				enterOuterAlt(_localctx, 6);
				{
				setState(111);
				file_directive();
				}
				break;
			case 7:
				enterOuterAlt(_localctx, 7);
				{
				setState(112);
				ifdef_directive();
				}
				break;
			case 8:
				enterOuterAlt(_localctx, 8);
				{
				setState(113);
				ifndef_directive();
				}
				break;
			case 9:
				enterOuterAlt(_localctx, 9);
				{
				setState(114);
				include_directive();
				}
				break;
			case 10:
				enterOuterAlt(_localctx, 10);
				{
				setState(115);
				line_directive();
				}
				break;
			case 11:
				enterOuterAlt(_localctx, 11);
				{
				setState(116);
				line_directive_();
				}
				break;
			case 12:
				enterOuterAlt(_localctx, 12);
				{
				setState(117);
				nounconnected_drive_directive();
				}
				break;
			case 13:
				enterOuterAlt(_localctx, 13);
				{
				setState(118);
				pragma_directive();
				}
				break;
			case 14:
				enterOuterAlt(_localctx, 14);
				{
				setState(119);
				resetall_directive();
				}
				break;
			case 15:
				enterOuterAlt(_localctx, 15);
				{
				setState(120);
				text_macro_definition();
				}
				break;
			case 16:
				enterOuterAlt(_localctx, 16);
				{
				setState(121);
				text_macro_usage();
				}
				break;
			case 17:
				enterOuterAlt(_localctx, 17);
				{
				setState(122);
				timescale_directive();
				}
				break;
			case 18:
				enterOuterAlt(_localctx, 18);
				{
				setState(123);
				unconnected_drive_directive();
				}
				break;
			case 19:
				enterOuterAlt(_localctx, 19);
				{
				setState(124);
				undef_directive();
				}
				break;
			case 20:
				enterOuterAlt(_localctx, 20);
				{
				setState(125);
				undefineall_directive();
				}
				break;
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class Begin_keywords_directiveContext extends ParserRuleContext {
		public TerminalNode GA() { return getToken(SystemVerilogPreParser.GA, 0); }
		public TerminalNode BEGIN_KEYWORDS_DIRECTIVE() { return getToken(SystemVerilogPreParser.BEGIN_KEYWORDS_DIRECTIVE, 0); }
		public List<TerminalNode> DQ() { return getTokens(SystemVerilogPreParser.DQ); }
		public TerminalNode DQ(int i) {
			return getToken(SystemVerilogPreParser.DQ, i);
		}
		public Version_specifierContext version_specifier() {
			return getRuleContext(Version_specifierContext.class,0);
		}
		public Begin_keywords_directiveContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_begin_keywords_directive; }
	}

	public final Begin_keywords_directiveContext begin_keywords_directive() throws RecognitionException {
		Begin_keywords_directiveContext _localctx = new Begin_keywords_directiveContext(_ctx, getState());
		enterRule(_localctx, 4, RULE_begin_keywords_directive);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(128);
			match(GA);
			setState(129);
			match(BEGIN_KEYWORDS_DIRECTIVE);
			setState(130);
			match(DQ);
			setState(131);
			version_specifier();
			setState(132);
			match(DQ);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class Celldefine_directiveContext extends ParserRuleContext {
		public TerminalNode GA() { return getToken(SystemVerilogPreParser.GA, 0); }
		public TerminalNode CELLDEFINE_DIRECTIVE() { return getToken(SystemVerilogPreParser.CELLDEFINE_DIRECTIVE, 0); }
		public Celldefine_directiveContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_celldefine_directive; }
	}

	public final Celldefine_directiveContext celldefine_directive() throws RecognitionException {
		Celldefine_directiveContext _localctx = new Celldefine_directiveContext(_ctx, getState());
		enterRule(_localctx, 6, RULE_celldefine_directive);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(134);
			match(GA);
			setState(135);
			match(CELLDEFINE_DIRECTIVE);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class Default_nettype_directiveContext extends ParserRuleContext {
		public TerminalNode GA() { return getToken(SystemVerilogPreParser.GA, 0); }
		public TerminalNode DEFAULT_NETTYPE_DIRECTIVE() { return getToken(SystemVerilogPreParser.DEFAULT_NETTYPE_DIRECTIVE, 0); }
		public Default_nettype_valueContext default_nettype_value() {
			return getRuleContext(Default_nettype_valueContext.class,0);
		}
		public Default_nettype_directiveContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_default_nettype_directive; }
	}

	public final Default_nettype_directiveContext default_nettype_directive() throws RecognitionException {
		Default_nettype_directiveContext _localctx = new Default_nettype_directiveContext(_ctx, getState());
		enterRule(_localctx, 8, RULE_default_nettype_directive);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(137);
			match(GA);
			setState(138);
			match(DEFAULT_NETTYPE_DIRECTIVE);
			setState(139);
			default_nettype_value();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class Default_nettype_valueContext extends ParserRuleContext {
		public TerminalNode DEFAULT_NETTYPE_VALUE() { return getToken(SystemVerilogPreParser.DEFAULT_NETTYPE_VALUE, 0); }
		public Default_nettype_valueContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_default_nettype_value; }
	}

	public final Default_nettype_valueContext default_nettype_value() throws RecognitionException {
		Default_nettype_valueContext _localctx = new Default_nettype_valueContext(_ctx, getState());
		enterRule(_localctx, 10, RULE_default_nettype_value);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(141);
			match(DEFAULT_NETTYPE_VALUE);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class Else_directiveContext extends ParserRuleContext {
		public TerminalNode GA() { return getToken(SystemVerilogPreParser.GA, 0); }
		public TerminalNode ELSE_DIRECTIVE() { return getToken(SystemVerilogPreParser.ELSE_DIRECTIVE, 0); }
		public Group_of_linesContext group_of_lines() {
			return getRuleContext(Group_of_linesContext.class,0);
		}
		public Else_directiveContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_else_directive; }
	}

	public final Else_directiveContext else_directive() throws RecognitionException {
		Else_directiveContext _localctx = new Else_directiveContext(_ctx, getState());
		enterRule(_localctx, 12, RULE_else_directive);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(143);
			match(GA);
			setState(144);
			match(ELSE_DIRECTIVE);
			setState(145);
			group_of_lines();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class Elsif_directiveContext extends ParserRuleContext {
		public TerminalNode GA() { return getToken(SystemVerilogPreParser.GA, 0); }
		public TerminalNode ELSIF_DIRECTIVE() { return getToken(SystemVerilogPreParser.ELSIF_DIRECTIVE, 0); }
		public Macro_identifierContext macro_identifier() {
			return getRuleContext(Macro_identifierContext.class,0);
		}
		public Group_of_linesContext group_of_lines() {
			return getRuleContext(Group_of_linesContext.class,0);
		}
		public Elsif_directiveContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_elsif_directive; }
	}

	public final Elsif_directiveContext elsif_directive() throws RecognitionException {
		Elsif_directiveContext _localctx = new Elsif_directiveContext(_ctx, getState());
		enterRule(_localctx, 14, RULE_elsif_directive);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(147);
			match(GA);
			setState(148);
			match(ELSIF_DIRECTIVE);
			setState(149);
			macro_identifier();
			setState(150);
			group_of_lines();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class End_keywords_directiveContext extends ParserRuleContext {
		public TerminalNode GA() { return getToken(SystemVerilogPreParser.GA, 0); }
		public TerminalNode END_KEYWORDS_DIRECTIVE() { return getToken(SystemVerilogPreParser.END_KEYWORDS_DIRECTIVE, 0); }
		public End_keywords_directiveContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_end_keywords_directive; }
	}

	public final End_keywords_directiveContext end_keywords_directive() throws RecognitionException {
		End_keywords_directiveContext _localctx = new End_keywords_directiveContext(_ctx, getState());
		enterRule(_localctx, 16, RULE_end_keywords_directive);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(152);
			match(GA);
			setState(153);
			match(END_KEYWORDS_DIRECTIVE);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class Endcelldefine_directiveContext extends ParserRuleContext {
		public TerminalNode GA() { return getToken(SystemVerilogPreParser.GA, 0); }
		public TerminalNode ENDCELLDEFINE_DIRECTIVE() { return getToken(SystemVerilogPreParser.ENDCELLDEFINE_DIRECTIVE, 0); }
		public Endcelldefine_directiveContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_endcelldefine_directive; }
	}

	public final Endcelldefine_directiveContext endcelldefine_directive() throws RecognitionException {
		Endcelldefine_directiveContext _localctx = new Endcelldefine_directiveContext(_ctx, getState());
		enterRule(_localctx, 18, RULE_endcelldefine_directive);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(155);
			match(GA);
			setState(156);
			match(ENDCELLDEFINE_DIRECTIVE);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class Endif_directiveContext extends ParserRuleContext {
		public TerminalNode GA() { return getToken(SystemVerilogPreParser.GA, 0); }
		public TerminalNode ENDIF_DIRECTIVE() { return getToken(SystemVerilogPreParser.ENDIF_DIRECTIVE, 0); }
		public Endif_directiveContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_endif_directive; }
	}

	public final Endif_directiveContext endif_directive() throws RecognitionException {
		Endif_directiveContext _localctx = new Endif_directiveContext(_ctx, getState());
		enterRule(_localctx, 20, RULE_endif_directive);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(158);
			match(GA);
			setState(159);
			match(ENDIF_DIRECTIVE);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class File_directiveContext extends ParserRuleContext {
		public TerminalNode GA() { return getToken(SystemVerilogPreParser.GA, 0); }
		public TerminalNode FILE_DIRECTIVE() { return getToken(SystemVerilogPreParser.FILE_DIRECTIVE, 0); }
		public File_directiveContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_file_directive; }
	}

	public final File_directiveContext file_directive() throws RecognitionException {
		File_directiveContext _localctx = new File_directiveContext(_ctx, getState());
		enterRule(_localctx, 22, RULE_file_directive);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(161);
			match(GA);
			setState(162);
			match(FILE_DIRECTIVE);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class FilenameContext extends ParserRuleContext {
		public TerminalNode FILENAME() { return getToken(SystemVerilogPreParser.FILENAME, 0); }
		public FilenameContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_filename; }
	}

	public final FilenameContext filename() throws RecognitionException {
		FilenameContext _localctx = new FilenameContext(_ctx, getState());
		enterRule(_localctx, 24, RULE_filename);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(164);
			match(FILENAME);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class Group_of_linesContext extends ParserRuleContext {
		public List<Source_text_Context> source_text_() {
			return getRuleContexts(Source_text_Context.class);
		}
		public Source_text_Context source_text_(int i) {
			return getRuleContext(Source_text_Context.class,i);
		}
		public List<Compiler_directiveContext> compiler_directive() {
			return getRuleContexts(Compiler_directiveContext.class);
		}
		public Compiler_directiveContext compiler_directive(int i) {
			return getRuleContext(Compiler_directiveContext.class,i);
		}
		public Group_of_linesContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_group_of_lines; }
	}

	public final Group_of_linesContext group_of_lines() throws RecognitionException {
		Group_of_linesContext _localctx = new Group_of_linesContext(_ctx, getState());
		enterRule(_localctx, 26, RULE_group_of_lines);
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			setState(170);
			_errHandler.sync(this);
			_alt = getInterpreter().adaptivePredict(_input,3,_ctx);
			while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER ) {
				if ( _alt==1 ) {
					{
					setState(168);
					_errHandler.sync(this);
					switch (_input.LA(1)) {
					case SOURCE_TEXT:
						{
						setState(166);
						source_text_();
						}
						break;
					case GA:
						{
						setState(167);
						compiler_directive();
						}
						break;
					default:
						throw new NoViableAltException(this);
					}
					} 
				}
				setState(172);
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,3,_ctx);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class IdentifierContext extends ParserRuleContext {
		public TerminalNode SIMPLE_IDENTIFIER() { return getToken(SystemVerilogPreParser.SIMPLE_IDENTIFIER, 0); }
		public IdentifierContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_identifier; }
	}

	public final IdentifierContext identifier() throws RecognitionException {
		IdentifierContext _localctx = new IdentifierContext(_ctx, getState());
		enterRule(_localctx, 28, RULE_identifier);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(173);
			match(SIMPLE_IDENTIFIER);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class Ifdef_directiveContext extends ParserRuleContext {
		public TerminalNode GA() { return getToken(SystemVerilogPreParser.GA, 0); }
		public TerminalNode IFDEF_DIRECTIVE() { return getToken(SystemVerilogPreParser.IFDEF_DIRECTIVE, 0); }
		public Macro_identifierContext macro_identifier() {
			return getRuleContext(Macro_identifierContext.class,0);
		}
		public Group_of_linesContext group_of_lines() {
			return getRuleContext(Group_of_linesContext.class,0);
		}
		public Endif_directiveContext endif_directive() {
			return getRuleContext(Endif_directiveContext.class,0);
		}
		public List<Elsif_directiveContext> elsif_directive() {
			return getRuleContexts(Elsif_directiveContext.class);
		}
		public Elsif_directiveContext elsif_directive(int i) {
			return getRuleContext(Elsif_directiveContext.class,i);
		}
		public Else_directiveContext else_directive() {
			return getRuleContext(Else_directiveContext.class,0);
		}
		public Ifdef_directiveContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_ifdef_directive; }
	}

	public final Ifdef_directiveContext ifdef_directive() throws RecognitionException {
		Ifdef_directiveContext _localctx = new Ifdef_directiveContext(_ctx, getState());
		enterRule(_localctx, 30, RULE_ifdef_directive);
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			setState(175);
			match(GA);
			setState(176);
			match(IFDEF_DIRECTIVE);
			setState(177);
			macro_identifier();
			setState(178);
			group_of_lines();
			setState(182);
			_errHandler.sync(this);
			_alt = getInterpreter().adaptivePredict(_input,4,_ctx);
			while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER ) {
				if ( _alt==1 ) {
					{
					{
					setState(179);
					elsif_directive();
					}
					} 
				}
				setState(184);
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,4,_ctx);
			}
			setState(186);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,5,_ctx) ) {
			case 1:
				{
				setState(185);
				else_directive();
				}
				break;
			}
			setState(188);
			endif_directive();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class Ifndef_directiveContext extends ParserRuleContext {
		public TerminalNode GA() { return getToken(SystemVerilogPreParser.GA, 0); }
		public TerminalNode IFNDEF_DIRECTIVE() { return getToken(SystemVerilogPreParser.IFNDEF_DIRECTIVE, 0); }
		public Macro_identifierContext macro_identifier() {
			return getRuleContext(Macro_identifierContext.class,0);
		}
		public Group_of_linesContext group_of_lines() {
			return getRuleContext(Group_of_linesContext.class,0);
		}
		public Endif_directiveContext endif_directive() {
			return getRuleContext(Endif_directiveContext.class,0);
		}
		public List<Elsif_directiveContext> elsif_directive() {
			return getRuleContexts(Elsif_directiveContext.class);
		}
		public Elsif_directiveContext elsif_directive(int i) {
			return getRuleContext(Elsif_directiveContext.class,i);
		}
		public Else_directiveContext else_directive() {
			return getRuleContext(Else_directiveContext.class,0);
		}
		public Ifndef_directiveContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_ifndef_directive; }
	}

	public final Ifndef_directiveContext ifndef_directive() throws RecognitionException {
		Ifndef_directiveContext _localctx = new Ifndef_directiveContext(_ctx, getState());
		enterRule(_localctx, 32, RULE_ifndef_directive);
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			setState(190);
			match(GA);
			setState(191);
			match(IFNDEF_DIRECTIVE);
			setState(192);
			macro_identifier();
			setState(193);
			group_of_lines();
			setState(197);
			_errHandler.sync(this);
			_alt = getInterpreter().adaptivePredict(_input,6,_ctx);
			while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER ) {
				if ( _alt==1 ) {
					{
					{
					setState(194);
					elsif_directive();
					}
					} 
				}
				setState(199);
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,6,_ctx);
			}
			setState(201);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,7,_ctx) ) {
			case 1:
				{
				setState(200);
				else_directive();
				}
				break;
			}
			setState(203);
			endif_directive();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class Include_directiveContext extends ParserRuleContext {
		public TerminalNode GA() { return getToken(SystemVerilogPreParser.GA, 0); }
		public TerminalNode INCLUDE_DIRECTIVE() { return getToken(SystemVerilogPreParser.INCLUDE_DIRECTIVE, 0); }
		public List<TerminalNode> DQ() { return getTokens(SystemVerilogPreParser.DQ); }
		public TerminalNode DQ(int i) {
			return getToken(SystemVerilogPreParser.DQ, i);
		}
		public FilenameContext filename() {
			return getRuleContext(FilenameContext.class,0);
		}
		public TerminalNode LT() { return getToken(SystemVerilogPreParser.LT, 0); }
		public TerminalNode GT() { return getToken(SystemVerilogPreParser.GT, 0); }
		public Text_macro_usageContext text_macro_usage() {
			return getRuleContext(Text_macro_usageContext.class,0);
		}
		public Include_directiveContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_include_directive; }
	}

	public final Include_directiveContext include_directive() throws RecognitionException {
		Include_directiveContext _localctx = new Include_directiveContext(_ctx, getState());
		enterRule(_localctx, 34, RULE_include_directive);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(205);
			match(GA);
			setState(206);
			match(INCLUDE_DIRECTIVE);
			setState(216);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case DQ:
				{
				setState(207);
				match(DQ);
				setState(208);
				filename();
				setState(209);
				match(DQ);
				}
				break;
			case LT:
				{
				setState(211);
				match(LT);
				setState(212);
				filename();
				setState(213);
				match(GT);
				}
				break;
			case GA:
				{
				setState(215);
				text_macro_usage();
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class LevelContext extends ParserRuleContext {
		public TerminalNode UNSIGNED_NUMBER() { return getToken(SystemVerilogPreParser.UNSIGNED_NUMBER, 0); }
		public LevelContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_level; }
	}

	public final LevelContext level() throws RecognitionException {
		LevelContext _localctx = new LevelContext(_ctx, getState());
		enterRule(_localctx, 36, RULE_level);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(218);
			match(UNSIGNED_NUMBER);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class Line_directiveContext extends ParserRuleContext {
		public TerminalNode GA() { return getToken(SystemVerilogPreParser.GA, 0); }
		public TerminalNode LINE_DIRECTIVE() { return getToken(SystemVerilogPreParser.LINE_DIRECTIVE, 0); }
		public NumberContext number() {
			return getRuleContext(NumberContext.class,0);
		}
		public List<TerminalNode> DQ() { return getTokens(SystemVerilogPreParser.DQ); }
		public TerminalNode DQ(int i) {
			return getToken(SystemVerilogPreParser.DQ, i);
		}
		public FilenameContext filename() {
			return getRuleContext(FilenameContext.class,0);
		}
		public LevelContext level() {
			return getRuleContext(LevelContext.class,0);
		}
		public Line_directiveContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_line_directive; }
	}

	public final Line_directiveContext line_directive() throws RecognitionException {
		Line_directiveContext _localctx = new Line_directiveContext(_ctx, getState());
		enterRule(_localctx, 38, RULE_line_directive);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(220);
			match(GA);
			setState(221);
			match(LINE_DIRECTIVE);
			setState(222);
			number();
			setState(223);
			match(DQ);
			setState(224);
			filename();
			setState(225);
			match(DQ);
			setState(226);
			level();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class Line_directive_Context extends ParserRuleContext {
		public TerminalNode GA() { return getToken(SystemVerilogPreParser.GA, 0); }
		public TerminalNode LINE_DIRECTIVE_() { return getToken(SystemVerilogPreParser.LINE_DIRECTIVE_, 0); }
		public Line_directive_Context(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_line_directive_; }
	}

	public final Line_directive_Context line_directive_() throws RecognitionException {
		Line_directive_Context _localctx = new Line_directive_Context(_ctx, getState());
		enterRule(_localctx, 40, RULE_line_directive_);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(228);
			match(GA);
			setState(229);
			match(LINE_DIRECTIVE_);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class Macro_delimiterContext extends ParserRuleContext {
		public TerminalNode MACRO_DELIMITER() { return getToken(SystemVerilogPreParser.MACRO_DELIMITER, 0); }
		public Macro_delimiterContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_macro_delimiter; }
	}

	public final Macro_delimiterContext macro_delimiter() throws RecognitionException {
		Macro_delimiterContext _localctx = new Macro_delimiterContext(_ctx, getState());
		enterRule(_localctx, 42, RULE_macro_delimiter);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(231);
			match(MACRO_DELIMITER);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class Macro_esc_newlineContext extends ParserRuleContext {
		public TerminalNode MACRO_ESC_NEWLINE() { return getToken(SystemVerilogPreParser.MACRO_ESC_NEWLINE, 0); }
		public Macro_esc_newlineContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_macro_esc_newline; }
	}

	public final Macro_esc_newlineContext macro_esc_newline() throws RecognitionException {
		Macro_esc_newlineContext _localctx = new Macro_esc_newlineContext(_ctx, getState());
		enterRule(_localctx, 44, RULE_macro_esc_newline);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(233);
			match(MACRO_ESC_NEWLINE);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class Macro_esc_quoteContext extends ParserRuleContext {
		public TerminalNode MACRO_ESC_QUOTE() { return getToken(SystemVerilogPreParser.MACRO_ESC_QUOTE, 0); }
		public Macro_esc_quoteContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_macro_esc_quote; }
	}

	public final Macro_esc_quoteContext macro_esc_quote() throws RecognitionException {
		Macro_esc_quoteContext _localctx = new Macro_esc_quoteContext(_ctx, getState());
		enterRule(_localctx, 46, RULE_macro_esc_quote);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(235);
			match(MACRO_ESC_QUOTE);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class Macro_identifierContext extends ParserRuleContext {
		public TerminalNode MACRO_IDENTIFIER() { return getToken(SystemVerilogPreParser.MACRO_IDENTIFIER, 0); }
		public Macro_identifierContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_macro_identifier; }
	}

	public final Macro_identifierContext macro_identifier() throws RecognitionException {
		Macro_identifierContext _localctx = new Macro_identifierContext(_ctx, getState());
		enterRule(_localctx, 48, RULE_macro_identifier);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(237);
			match(MACRO_IDENTIFIER);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class Macro_nameContext extends ParserRuleContext {
		public TerminalNode MACRO_NAME() { return getToken(SystemVerilogPreParser.MACRO_NAME, 0); }
		public Macro_nameContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_macro_name; }
	}

	public final Macro_nameContext macro_name() throws RecognitionException {
		Macro_nameContext _localctx = new Macro_nameContext(_ctx, getState());
		enterRule(_localctx, 50, RULE_macro_name);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(239);
			match(MACRO_NAME);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class Macro_quoteContext extends ParserRuleContext {
		public TerminalNode MACRO_QUOTE() { return getToken(SystemVerilogPreParser.MACRO_QUOTE, 0); }
		public Macro_quoteContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_macro_quote; }
	}

	public final Macro_quoteContext macro_quote() throws RecognitionException {
		Macro_quoteContext _localctx = new Macro_quoteContext(_ctx, getState());
		enterRule(_localctx, 52, RULE_macro_quote);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(241);
			match(MACRO_QUOTE);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class Macro_textContext extends ParserRuleContext {
		public List<Macro_text_Context> macro_text_() {
			return getRuleContexts(Macro_text_Context.class);
		}
		public Macro_text_Context macro_text_(int i) {
			return getRuleContext(Macro_text_Context.class,i);
		}
		public List<Macro_delimiterContext> macro_delimiter() {
			return getRuleContexts(Macro_delimiterContext.class);
		}
		public Macro_delimiterContext macro_delimiter(int i) {
			return getRuleContext(Macro_delimiterContext.class,i);
		}
		public List<Macro_esc_newlineContext> macro_esc_newline() {
			return getRuleContexts(Macro_esc_newlineContext.class);
		}
		public Macro_esc_newlineContext macro_esc_newline(int i) {
			return getRuleContext(Macro_esc_newlineContext.class,i);
		}
		public List<Macro_esc_quoteContext> macro_esc_quote() {
			return getRuleContexts(Macro_esc_quoteContext.class);
		}
		public Macro_esc_quoteContext macro_esc_quote(int i) {
			return getRuleContext(Macro_esc_quoteContext.class,i);
		}
		public List<Macro_quoteContext> macro_quote() {
			return getRuleContexts(Macro_quoteContext.class);
		}
		public Macro_quoteContext macro_quote(int i) {
			return getRuleContext(Macro_quoteContext.class,i);
		}
		public List<String_literalContext> string_literal() {
			return getRuleContexts(String_literalContext.class);
		}
		public String_literalContext string_literal(int i) {
			return getRuleContext(String_literalContext.class,i);
		}
		public Macro_textContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_macro_text; }
	}

	public final Macro_textContext macro_text() throws RecognitionException {
		Macro_textContext _localctx = new Macro_textContext(_ctx, getState());
		enterRule(_localctx, 54, RULE_macro_text);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(251);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while (((((_la - 367)) & ~0x3f) == 0 && ((1L << (_la - 367)) & 136339441844225L) != 0)) {
				{
				setState(249);
				_errHandler.sync(this);
				switch (_input.LA(1)) {
				case MACRO_TEXT:
					{
					setState(243);
					macro_text_();
					}
					break;
				case MACRO_DELIMITER:
					{
					setState(244);
					macro_delimiter();
					}
					break;
				case MACRO_ESC_NEWLINE:
					{
					setState(245);
					macro_esc_newline();
					}
					break;
				case MACRO_ESC_QUOTE:
					{
					setState(246);
					macro_esc_quote();
					}
					break;
				case MACRO_QUOTE:
					{
					setState(247);
					macro_quote();
					}
					break;
				case STRING_LITERAL:
					{
					setState(248);
					string_literal();
					}
					break;
				default:
					throw new NoViableAltException(this);
				}
				}
				setState(253);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class Macro_text_Context extends ParserRuleContext {
		public TerminalNode MACRO_TEXT() { return getToken(SystemVerilogPreParser.MACRO_TEXT, 0); }
		public Macro_text_Context(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_macro_text_; }
	}

	public final Macro_text_Context macro_text_() throws RecognitionException {
		Macro_text_Context _localctx = new Macro_text_Context(_ctx, getState());
		enterRule(_localctx, 56, RULE_macro_text_);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(254);
			match(MACRO_TEXT);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class Macro_usageContext extends ParserRuleContext {
		public TerminalNode MACRO_USAGE() { return getToken(SystemVerilogPreParser.MACRO_USAGE, 0); }
		public Macro_usageContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_macro_usage; }
	}

	public final Macro_usageContext macro_usage() throws RecognitionException {
		Macro_usageContext _localctx = new Macro_usageContext(_ctx, getState());
		enterRule(_localctx, 58, RULE_macro_usage);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(256);
			match(MACRO_USAGE);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class Nounconnected_drive_directiveContext extends ParserRuleContext {
		public TerminalNode GA() { return getToken(SystemVerilogPreParser.GA, 0); }
		public TerminalNode NOUNCONNECTED_DRIVE_DIRECTIVE() { return getToken(SystemVerilogPreParser.NOUNCONNECTED_DRIVE_DIRECTIVE, 0); }
		public Nounconnected_drive_directiveContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_nounconnected_drive_directive; }
	}

	public final Nounconnected_drive_directiveContext nounconnected_drive_directive() throws RecognitionException {
		Nounconnected_drive_directiveContext _localctx = new Nounconnected_drive_directiveContext(_ctx, getState());
		enterRule(_localctx, 60, RULE_nounconnected_drive_directive);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(258);
			match(GA);
			setState(259);
			match(NOUNCONNECTED_DRIVE_DIRECTIVE);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class NumberContext extends ParserRuleContext {
		public TerminalNode UNSIGNED_NUMBER() { return getToken(SystemVerilogPreParser.UNSIGNED_NUMBER, 0); }
		public NumberContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_number; }
	}

	public final NumberContext number() throws RecognitionException {
		NumberContext _localctx = new NumberContext(_ctx, getState());
		enterRule(_localctx, 62, RULE_number);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(261);
			match(UNSIGNED_NUMBER);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class Pragma_directiveContext extends ParserRuleContext {
		public TerminalNode GA() { return getToken(SystemVerilogPreParser.GA, 0); }
		public TerminalNode PRAGMA_DIRECTIVE() { return getToken(SystemVerilogPreParser.PRAGMA_DIRECTIVE, 0); }
		public Pragma_nameContext pragma_name() {
			return getRuleContext(Pragma_nameContext.class,0);
		}
		public List<Pragma_expressionContext> pragma_expression() {
			return getRuleContexts(Pragma_expressionContext.class);
		}
		public Pragma_expressionContext pragma_expression(int i) {
			return getRuleContext(Pragma_expressionContext.class,i);
		}
		public List<TerminalNode> CO() { return getTokens(SystemVerilogPreParser.CO); }
		public TerminalNode CO(int i) {
			return getToken(SystemVerilogPreParser.CO, i);
		}
		public Pragma_directiveContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_pragma_directive; }
	}

	public final Pragma_directiveContext pragma_directive() throws RecognitionException {
		Pragma_directiveContext _localctx = new Pragma_directiveContext(_ctx, getState());
		enterRule(_localctx, 64, RULE_pragma_directive);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(263);
			match(GA);
			setState(264);
			match(PRAGMA_DIRECTIVE);
			setState(265);
			pragma_name();
			setState(274);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (((((_la - 321)) & ~0x3f) == 0 && ((1L << (_la - 321)) & 1231453023109121L) != 0)) {
				{
				setState(266);
				pragma_expression();
				setState(271);
				_errHandler.sync(this);
				_la = _input.LA(1);
				while (_la==CO) {
					{
					{
					setState(267);
					match(CO);
					setState(268);
					pragma_expression();
					}
					}
					setState(273);
					_errHandler.sync(this);
					_la = _input.LA(1);
				}
				}
			}

			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class Pragma_expressionContext extends ParserRuleContext {
		public Pragma_valueContext pragma_value() {
			return getRuleContext(Pragma_valueContext.class,0);
		}
		public Pragma_keywordContext pragma_keyword() {
			return getRuleContext(Pragma_keywordContext.class,0);
		}
		public TerminalNode EQ() { return getToken(SystemVerilogPreParser.EQ, 0); }
		public Pragma_expressionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_pragma_expression; }
	}

	public final Pragma_expressionContext pragma_expression() throws RecognitionException {
		Pragma_expressionContext _localctx = new Pragma_expressionContext(_ctx, getState());
		enterRule(_localctx, 66, RULE_pragma_expression);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(279);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,13,_ctx) ) {
			case 1:
				{
				setState(276);
				pragma_keyword();
				setState(277);
				match(EQ);
				}
				break;
			}
			setState(281);
			pragma_value();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class Pragma_keywordContext extends ParserRuleContext {
		public TerminalNode SIMPLE_IDENTIFIER() { return getToken(SystemVerilogPreParser.SIMPLE_IDENTIFIER, 0); }
		public Pragma_keywordContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_pragma_keyword; }
	}

	public final Pragma_keywordContext pragma_keyword() throws RecognitionException {
		Pragma_keywordContext _localctx = new Pragma_keywordContext(_ctx, getState());
		enterRule(_localctx, 68, RULE_pragma_keyword);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(283);
			match(SIMPLE_IDENTIFIER);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class Pragma_nameContext extends ParserRuleContext {
		public TerminalNode SIMPLE_IDENTIFIER() { return getToken(SystemVerilogPreParser.SIMPLE_IDENTIFIER, 0); }
		public Pragma_nameContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_pragma_name; }
	}

	public final Pragma_nameContext pragma_name() throws RecognitionException {
		Pragma_nameContext _localctx = new Pragma_nameContext(_ctx, getState());
		enterRule(_localctx, 70, RULE_pragma_name);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(285);
			match(SIMPLE_IDENTIFIER);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class Pragma_valueContext extends ParserRuleContext {
		public TerminalNode LP() { return getToken(SystemVerilogPreParser.LP, 0); }
		public List<Pragma_expressionContext> pragma_expression() {
			return getRuleContexts(Pragma_expressionContext.class);
		}
		public Pragma_expressionContext pragma_expression(int i) {
			return getRuleContext(Pragma_expressionContext.class,i);
		}
		public TerminalNode RP() { return getToken(SystemVerilogPreParser.RP, 0); }
		public List<TerminalNode> CO() { return getTokens(SystemVerilogPreParser.CO); }
		public TerminalNode CO(int i) {
			return getToken(SystemVerilogPreParser.CO, i);
		}
		public NumberContext number() {
			return getRuleContext(NumberContext.class,0);
		}
		public String_literalContext string_literal() {
			return getRuleContext(String_literalContext.class,0);
		}
		public IdentifierContext identifier() {
			return getRuleContext(IdentifierContext.class,0);
		}
		public Pragma_valueContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_pragma_value; }
	}

	public final Pragma_valueContext pragma_value() throws RecognitionException {
		Pragma_valueContext _localctx = new Pragma_valueContext(_ctx, getState());
		enterRule(_localctx, 72, RULE_pragma_value);
		int _la;
		try {
			setState(301);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case LP:
				enterOuterAlt(_localctx, 1);
				{
				setState(287);
				match(LP);
				setState(288);
				pragma_expression();
				setState(293);
				_errHandler.sync(this);
				_la = _input.LA(1);
				while (_la==CO) {
					{
					{
					setState(289);
					match(CO);
					setState(290);
					pragma_expression();
					}
					}
					setState(295);
					_errHandler.sync(this);
					_la = _input.LA(1);
				}
				setState(296);
				match(RP);
				}
				break;
			case UNSIGNED_NUMBER:
				enterOuterAlt(_localctx, 2);
				{
				setState(298);
				number();
				}
				break;
			case STRING_LITERAL:
				enterOuterAlt(_localctx, 3);
				{
				setState(299);
				string_literal();
				}
				break;
			case SIMPLE_IDENTIFIER:
				enterOuterAlt(_localctx, 4);
				{
				setState(300);
				identifier();
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class Resetall_directiveContext extends ParserRuleContext {
		public TerminalNode GA() { return getToken(SystemVerilogPreParser.GA, 0); }
		public TerminalNode RESETALL_DIRECTIVE() { return getToken(SystemVerilogPreParser.RESETALL_DIRECTIVE, 0); }
		public Resetall_directiveContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_resetall_directive; }
	}

	public final Resetall_directiveContext resetall_directive() throws RecognitionException {
		Resetall_directiveContext _localctx = new Resetall_directiveContext(_ctx, getState());
		enterRule(_localctx, 74, RULE_resetall_directive);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(303);
			match(GA);
			setState(304);
			match(RESETALL_DIRECTIVE);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class Source_text_Context extends ParserRuleContext {
		public TerminalNode SOURCE_TEXT() { return getToken(SystemVerilogPreParser.SOURCE_TEXT, 0); }
		public Source_text_Context(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_source_text_; }
	}

	public final Source_text_Context source_text_() throws RecognitionException {
		Source_text_Context _localctx = new Source_text_Context(_ctx, getState());
		enterRule(_localctx, 76, RULE_source_text_);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(306);
			match(SOURCE_TEXT);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class String_literalContext extends ParserRuleContext {
		public TerminalNode STRING_LITERAL() { return getToken(SystemVerilogPreParser.STRING_LITERAL, 0); }
		public String_literalContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_string_literal; }
	}

	public final String_literalContext string_literal() throws RecognitionException {
		String_literalContext _localctx = new String_literalContext(_ctx, getState());
		enterRule(_localctx, 78, RULE_string_literal);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(308);
			match(STRING_LITERAL);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class Text_macro_definitionContext extends ParserRuleContext {
		public TerminalNode GA() { return getToken(SystemVerilogPreParser.GA, 0); }
		public TerminalNode DEFINE_DIRECTIVE() { return getToken(SystemVerilogPreParser.DEFINE_DIRECTIVE, 0); }
		public Macro_nameContext macro_name() {
			return getRuleContext(Macro_nameContext.class,0);
		}
		public Macro_textContext macro_text() {
			return getRuleContext(Macro_textContext.class,0);
		}
		public Text_macro_definitionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_text_macro_definition; }
	}

	public final Text_macro_definitionContext text_macro_definition() throws RecognitionException {
		Text_macro_definitionContext _localctx = new Text_macro_definitionContext(_ctx, getState());
		enterRule(_localctx, 80, RULE_text_macro_definition);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(310);
			match(GA);
			setState(311);
			match(DEFINE_DIRECTIVE);
			setState(312);
			macro_name();
			setState(313);
			macro_text();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class Text_macro_usageContext extends ParserRuleContext {
		public TerminalNode GA() { return getToken(SystemVerilogPreParser.GA, 0); }
		public Macro_usageContext macro_usage() {
			return getRuleContext(Macro_usageContext.class,0);
		}
		public Text_macro_usageContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_text_macro_usage; }
	}

	public final Text_macro_usageContext text_macro_usage() throws RecognitionException {
		Text_macro_usageContext _localctx = new Text_macro_usageContext(_ctx, getState());
		enterRule(_localctx, 82, RULE_text_macro_usage);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(315);
			match(GA);
			setState(316);
			macro_usage();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class Time_precisionContext extends ParserRuleContext {
		public TerminalNode TIME_VALUE() { return getToken(SystemVerilogPreParser.TIME_VALUE, 0); }
		public TerminalNode TIME_UNIT() { return getToken(SystemVerilogPreParser.TIME_UNIT, 0); }
		public Time_precisionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_time_precision; }
	}

	public final Time_precisionContext time_precision() throws RecognitionException {
		Time_precisionContext _localctx = new Time_precisionContext(_ctx, getState());
		enterRule(_localctx, 84, RULE_time_precision);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(318);
			match(TIME_VALUE);
			setState(319);
			match(TIME_UNIT);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class Time_unitContext extends ParserRuleContext {
		public TerminalNode TIME_VALUE() { return getToken(SystemVerilogPreParser.TIME_VALUE, 0); }
		public TerminalNode TIME_UNIT() { return getToken(SystemVerilogPreParser.TIME_UNIT, 0); }
		public Time_unitContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_time_unit; }
	}

	public final Time_unitContext time_unit() throws RecognitionException {
		Time_unitContext _localctx = new Time_unitContext(_ctx, getState());
		enterRule(_localctx, 86, RULE_time_unit);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(321);
			match(TIME_VALUE);
			setState(322);
			match(TIME_UNIT);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class Timescale_directiveContext extends ParserRuleContext {
		public TerminalNode GA() { return getToken(SystemVerilogPreParser.GA, 0); }
		public TerminalNode TIMESCALE_DIRECTIVE() { return getToken(SystemVerilogPreParser.TIMESCALE_DIRECTIVE, 0); }
		public Time_unitContext time_unit() {
			return getRuleContext(Time_unitContext.class,0);
		}
		public TerminalNode SL() { return getToken(SystemVerilogPreParser.SL, 0); }
		public Time_precisionContext time_precision() {
			return getRuleContext(Time_precisionContext.class,0);
		}
		public Timescale_directiveContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_timescale_directive; }
	}

	public final Timescale_directiveContext timescale_directive() throws RecognitionException {
		Timescale_directiveContext _localctx = new Timescale_directiveContext(_ctx, getState());
		enterRule(_localctx, 88, RULE_timescale_directive);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(324);
			match(GA);
			setState(325);
			match(TIMESCALE_DIRECTIVE);
			setState(326);
			time_unit();
			setState(327);
			match(SL);
			setState(328);
			time_precision();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class Unconnected_drive_directiveContext extends ParserRuleContext {
		public TerminalNode GA() { return getToken(SystemVerilogPreParser.GA, 0); }
		public TerminalNode UNCONNECTED_DRIVE_DIRECTIVE() { return getToken(SystemVerilogPreParser.UNCONNECTED_DRIVE_DIRECTIVE, 0); }
		public Unconnected_drive_valueContext unconnected_drive_value() {
			return getRuleContext(Unconnected_drive_valueContext.class,0);
		}
		public Unconnected_drive_directiveContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_unconnected_drive_directive; }
	}

	public final Unconnected_drive_directiveContext unconnected_drive_directive() throws RecognitionException {
		Unconnected_drive_directiveContext _localctx = new Unconnected_drive_directiveContext(_ctx, getState());
		enterRule(_localctx, 90, RULE_unconnected_drive_directive);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(330);
			match(GA);
			setState(331);
			match(UNCONNECTED_DRIVE_DIRECTIVE);
			setState(332);
			unconnected_drive_value();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class Unconnected_drive_valueContext extends ParserRuleContext {
		public TerminalNode UNCONNECTED_DRIVE_VALUE() { return getToken(SystemVerilogPreParser.UNCONNECTED_DRIVE_VALUE, 0); }
		public Unconnected_drive_valueContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_unconnected_drive_value; }
	}

	public final Unconnected_drive_valueContext unconnected_drive_value() throws RecognitionException {
		Unconnected_drive_valueContext _localctx = new Unconnected_drive_valueContext(_ctx, getState());
		enterRule(_localctx, 92, RULE_unconnected_drive_value);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(334);
			match(UNCONNECTED_DRIVE_VALUE);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class Undef_directiveContext extends ParserRuleContext {
		public TerminalNode GA() { return getToken(SystemVerilogPreParser.GA, 0); }
		public TerminalNode UNDEF_DIRECTIVE() { return getToken(SystemVerilogPreParser.UNDEF_DIRECTIVE, 0); }
		public Macro_identifierContext macro_identifier() {
			return getRuleContext(Macro_identifierContext.class,0);
		}
		public Undef_directiveContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_undef_directive; }
	}

	public final Undef_directiveContext undef_directive() throws RecognitionException {
		Undef_directiveContext _localctx = new Undef_directiveContext(_ctx, getState());
		enterRule(_localctx, 94, RULE_undef_directive);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(336);
			match(GA);
			setState(337);
			match(UNDEF_DIRECTIVE);
			setState(338);
			macro_identifier();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class Undefineall_directiveContext extends ParserRuleContext {
		public TerminalNode GA() { return getToken(SystemVerilogPreParser.GA, 0); }
		public TerminalNode UNDEFINEALL_DIRECTIVE() { return getToken(SystemVerilogPreParser.UNDEFINEALL_DIRECTIVE, 0); }
		public Undefineall_directiveContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_undefineall_directive; }
	}

	public final Undefineall_directiveContext undefineall_directive() throws RecognitionException {
		Undefineall_directiveContext _localctx = new Undefineall_directiveContext(_ctx, getState());
		enterRule(_localctx, 96, RULE_undefineall_directive);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(340);
			match(GA);
			setState(341);
			match(UNDEFINEALL_DIRECTIVE);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class Version_specifierContext extends ParserRuleContext {
		public TerminalNode VERSION_SPECIFIER() { return getToken(SystemVerilogPreParser.VERSION_SPECIFIER, 0); }
		public Version_specifierContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_version_specifier; }
	}

	public final Version_specifierContext version_specifier() throws RecognitionException {
		Version_specifierContext _localctx = new Version_specifierContext(_ctx, getState());
		enterRule(_localctx, 98, RULE_version_specifier);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(343);
			match(VERSION_SPECIFIER);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static final String _serializedATN =
		"\u0004\u0001\u01a2\u015a\u0002\u0000\u0007\u0000\u0002\u0001\u0007\u0001"+
		"\u0002\u0002\u0007\u0002\u0002\u0003\u0007\u0003\u0002\u0004\u0007\u0004"+
		"\u0002\u0005\u0007\u0005\u0002\u0006\u0007\u0006\u0002\u0007\u0007\u0007"+
		"\u0002\b\u0007\b\u0002\t\u0007\t\u0002\n\u0007\n\u0002\u000b\u0007\u000b"+
		"\u0002\f\u0007\f\u0002\r\u0007\r\u0002\u000e\u0007\u000e\u0002\u000f\u0007"+
		"\u000f\u0002\u0010\u0007\u0010\u0002\u0011\u0007\u0011\u0002\u0012\u0007"+
		"\u0012\u0002\u0013\u0007\u0013\u0002\u0014\u0007\u0014\u0002\u0015\u0007"+
		"\u0015\u0002\u0016\u0007\u0016\u0002\u0017\u0007\u0017\u0002\u0018\u0007"+
		"\u0018\u0002\u0019\u0007\u0019\u0002\u001a\u0007\u001a\u0002\u001b\u0007"+
		"\u001b\u0002\u001c\u0007\u001c\u0002\u001d\u0007\u001d\u0002\u001e\u0007"+
		"\u001e\u0002\u001f\u0007\u001f\u0002 \u0007 \u0002!\u0007!\u0002\"\u0007"+
		"\"\u0002#\u0007#\u0002$\u0007$\u0002%\u0007%\u0002&\u0007&\u0002\'\u0007"+
		"\'\u0002(\u0007(\u0002)\u0007)\u0002*\u0007*\u0002+\u0007+\u0002,\u0007"+
		",\u0002-\u0007-\u0002.\u0007.\u0002/\u0007/\u00020\u00070\u00021\u0007"+
		"1\u0001\u0000\u0005\u0000f\b\u0000\n\u0000\f\u0000i\t\u0000\u0001\u0001"+
		"\u0001\u0001\u0001\u0001\u0001\u0001\u0001\u0001\u0001\u0001\u0001\u0001"+
		"\u0001\u0001\u0001\u0001\u0001\u0001\u0001\u0001\u0001\u0001\u0001\u0001"+
		"\u0001\u0001\u0001\u0001\u0001\u0001\u0001\u0001\u0001\u0001\u0001\u0001"+
		"\u0001\u0001\u0003\u0001\u007f\b\u0001\u0001\u0002\u0001\u0002\u0001\u0002"+
		"\u0001\u0002\u0001\u0002\u0001\u0002\u0001\u0003\u0001\u0003\u0001\u0003"+
		"\u0001\u0004\u0001\u0004\u0001\u0004\u0001\u0004\u0001\u0005\u0001\u0005"+
		"\u0001\u0006\u0001\u0006\u0001\u0006\u0001\u0006\u0001\u0007\u0001\u0007"+
		"\u0001\u0007\u0001\u0007\u0001\u0007\u0001\b\u0001\b\u0001\b\u0001\t\u0001"+
		"\t\u0001\t\u0001\n\u0001\n\u0001\n\u0001\u000b\u0001\u000b\u0001\u000b"+
		"\u0001\f\u0001\f\u0001\r\u0001\r\u0005\r\u00a9\b\r\n\r\f\r\u00ac\t\r\u0001"+
		"\u000e\u0001\u000e\u0001\u000f\u0001\u000f\u0001\u000f\u0001\u000f\u0001"+
		"\u000f\u0005\u000f\u00b5\b\u000f\n\u000f\f\u000f\u00b8\t\u000f\u0001\u000f"+
		"\u0003\u000f\u00bb\b\u000f\u0001\u000f\u0001\u000f\u0001\u0010\u0001\u0010"+
		"\u0001\u0010\u0001\u0010\u0001\u0010\u0005\u0010\u00c4\b\u0010\n\u0010"+
		"\f\u0010\u00c7\t\u0010\u0001\u0010\u0003\u0010\u00ca\b\u0010\u0001\u0010"+
		"\u0001\u0010\u0001\u0011\u0001\u0011\u0001\u0011\u0001\u0011\u0001\u0011"+
		"\u0001\u0011\u0001\u0011\u0001\u0011\u0001\u0011\u0001\u0011\u0001\u0011"+
		"\u0003\u0011\u00d9\b\u0011\u0001\u0012\u0001\u0012\u0001\u0013\u0001\u0013"+
		"\u0001\u0013\u0001\u0013\u0001\u0013\u0001\u0013\u0001\u0013\u0001\u0013"+
		"\u0001\u0014\u0001\u0014\u0001\u0014\u0001\u0015\u0001\u0015\u0001\u0016"+
		"\u0001\u0016\u0001\u0017\u0001\u0017\u0001\u0018\u0001\u0018\u0001\u0019"+
		"\u0001\u0019\u0001\u001a\u0001\u001a\u0001\u001b\u0001\u001b\u0001\u001b"+
		"\u0001\u001b\u0001\u001b\u0001\u001b\u0005\u001b\u00fa\b\u001b\n\u001b"+
		"\f\u001b\u00fd\t\u001b\u0001\u001c\u0001\u001c\u0001\u001d\u0001\u001d"+
		"\u0001\u001e\u0001\u001e\u0001\u001e\u0001\u001f\u0001\u001f\u0001 \u0001"+
		" \u0001 \u0001 \u0001 \u0001 \u0005 \u010e\b \n \f \u0111\t \u0003 \u0113"+
		"\b \u0001!\u0001!\u0001!\u0003!\u0118\b!\u0001!\u0001!\u0001\"\u0001\""+
		"\u0001#\u0001#\u0001$\u0001$\u0001$\u0001$\u0005$\u0124\b$\n$\f$\u0127"+
		"\t$\u0001$\u0001$\u0001$\u0001$\u0001$\u0003$\u012e\b$\u0001%\u0001%\u0001"+
		"%\u0001&\u0001&\u0001\'\u0001\'\u0001(\u0001(\u0001(\u0001(\u0001(\u0001"+
		")\u0001)\u0001)\u0001*\u0001*\u0001*\u0001+\u0001+\u0001+\u0001,\u0001"+
		",\u0001,\u0001,\u0001,\u0001,\u0001-\u0001-\u0001-\u0001-\u0001.\u0001"+
		".\u0001/\u0001/\u0001/\u0001/\u00010\u00010\u00010\u00011\u00011\u0001"+
		"1\u0000\u00002\u0000\u0002\u0004\u0006\b\n\f\u000e\u0010\u0012\u0014\u0016"+
		"\u0018\u001a\u001c\u001e \"$&(*,.02468:<>@BDFHJLNPRTVXZ\\^`b\u0000\u0000"+
		"\u0150\u0000g\u0001\u0000\u0000\u0000\u0002~\u0001\u0000\u0000\u0000\u0004"+
		"\u0080\u0001\u0000\u0000\u0000\u0006\u0086\u0001\u0000\u0000\u0000\b\u0089"+
		"\u0001\u0000\u0000\u0000\n\u008d\u0001\u0000\u0000\u0000\f\u008f\u0001"+
		"\u0000\u0000\u0000\u000e\u0093\u0001\u0000\u0000\u0000\u0010\u0098\u0001"+
		"\u0000\u0000\u0000\u0012\u009b\u0001\u0000\u0000\u0000\u0014\u009e\u0001"+
		"\u0000\u0000\u0000\u0016\u00a1\u0001\u0000\u0000\u0000\u0018\u00a4\u0001"+
		"\u0000\u0000\u0000\u001a\u00aa\u0001\u0000\u0000\u0000\u001c\u00ad\u0001"+
		"\u0000\u0000\u0000\u001e\u00af\u0001\u0000\u0000\u0000 \u00be\u0001\u0000"+
		"\u0000\u0000\"\u00cd\u0001\u0000\u0000\u0000$\u00da\u0001\u0000\u0000"+
		"\u0000&\u00dc\u0001\u0000\u0000\u0000(\u00e4\u0001\u0000\u0000\u0000*"+
		"\u00e7\u0001\u0000\u0000\u0000,\u00e9\u0001\u0000\u0000\u0000.\u00eb\u0001"+
		"\u0000\u0000\u00000\u00ed\u0001\u0000\u0000\u00002\u00ef\u0001\u0000\u0000"+
		"\u00004\u00f1\u0001\u0000\u0000\u00006\u00fb\u0001\u0000\u0000\u00008"+
		"\u00fe\u0001\u0000\u0000\u0000:\u0100\u0001\u0000\u0000\u0000<\u0102\u0001"+
		"\u0000\u0000\u0000>\u0105\u0001\u0000\u0000\u0000@\u0107\u0001\u0000\u0000"+
		"\u0000B\u0117\u0001\u0000\u0000\u0000D\u011b\u0001\u0000\u0000\u0000F"+
		"\u011d\u0001\u0000\u0000\u0000H\u012d\u0001\u0000\u0000\u0000J\u012f\u0001"+
		"\u0000\u0000\u0000L\u0132\u0001\u0000\u0000\u0000N\u0134\u0001\u0000\u0000"+
		"\u0000P\u0136\u0001\u0000\u0000\u0000R\u013b\u0001\u0000\u0000\u0000T"+
		"\u013e\u0001\u0000\u0000\u0000V\u0141\u0001\u0000\u0000\u0000X\u0144\u0001"+
		"\u0000\u0000\u0000Z\u014a\u0001\u0000\u0000\u0000\\\u014e\u0001\u0000"+
		"\u0000\u0000^\u0150\u0001\u0000\u0000\u0000`\u0154\u0001\u0000\u0000\u0000"+
		"b\u0157\u0001\u0000\u0000\u0000df\u0003\u0002\u0001\u0000ed\u0001\u0000"+
		"\u0000\u0000fi\u0001\u0000\u0000\u0000ge\u0001\u0000\u0000\u0000gh\u0001"+
		"\u0000\u0000\u0000h\u0001\u0001\u0000\u0000\u0000ig\u0001\u0000\u0000"+
		"\u0000j\u007f\u0003\u0004\u0002\u0000k\u007f\u0003\u0006\u0003\u0000l"+
		"\u007f\u0003\b\u0004\u0000m\u007f\u0003\u0010\b\u0000n\u007f\u0003\u0012"+
		"\t\u0000o\u007f\u0003\u0016\u000b\u0000p\u007f\u0003\u001e\u000f\u0000"+
		"q\u007f\u0003 \u0010\u0000r\u007f\u0003\"\u0011\u0000s\u007f\u0003&\u0013"+
		"\u0000t\u007f\u0003(\u0014\u0000u\u007f\u0003<\u001e\u0000v\u007f\u0003"+
		"@ \u0000w\u007f\u0003J%\u0000x\u007f\u0003P(\u0000y\u007f\u0003R)\u0000"+
		"z\u007f\u0003X,\u0000{\u007f\u0003Z-\u0000|\u007f\u0003^/\u0000}\u007f"+
		"\u0003`0\u0000~j\u0001\u0000\u0000\u0000~k\u0001\u0000\u0000\u0000~l\u0001"+
		"\u0000\u0000\u0000~m\u0001\u0000\u0000\u0000~n\u0001\u0000\u0000\u0000"+
		"~o\u0001\u0000\u0000\u0000~p\u0001\u0000\u0000\u0000~q\u0001\u0000\u0000"+
		"\u0000~r\u0001\u0000\u0000\u0000~s\u0001\u0000\u0000\u0000~t\u0001\u0000"+
		"\u0000\u0000~u\u0001\u0000\u0000\u0000~v\u0001\u0000\u0000\u0000~w\u0001"+
		"\u0000\u0000\u0000~x\u0001\u0000\u0000\u0000~y\u0001\u0000\u0000\u0000"+
		"~z\u0001\u0000\u0000\u0000~{\u0001\u0000\u0000\u0000~|\u0001\u0000\u0000"+
		"\u0000~}\u0001\u0000\u0000\u0000\u007f\u0003\u0001\u0000\u0000\u0000\u0080"+
		"\u0081\u0005\u0134\u0000\u0000\u0081\u0082\u0005\u017e\u0000\u0000\u0082"+
		"\u0083\u0005\u0128\u0000\u0000\u0083\u0084\u0003b1\u0000\u0084\u0085\u0005"+
		"\u0128\u0000\u0000\u0085\u0005\u0001\u0000\u0000\u0000\u0086\u0087\u0005"+
		"\u0134\u0000\u0000\u0087\u0088\u0005\u017f\u0000\u0000\u0088\u0007\u0001"+
		"\u0000\u0000\u0000\u0089\u008a\u0005\u0134\u0000\u0000\u008a\u008b\u0005"+
		"\u0180\u0000\u0000\u008b\u008c\u0003\n\u0005\u0000\u008c\t\u0001\u0000"+
		"\u0000\u0000\u008d\u008e\u0005\u0196\u0000\u0000\u008e\u000b\u0001\u0000"+
		"\u0000\u0000\u008f\u0090\u0005\u0134\u0000\u0000\u0090\u0091\u0005\u0182"+
		"\u0000\u0000\u0091\u0092\u0003\u001a\r\u0000\u0092\r\u0001\u0000\u0000"+
		"\u0000\u0093\u0094\u0005\u0134\u0000\u0000\u0094\u0095\u0005\u0183\u0000"+
		"\u0000\u0095\u0096\u00030\u0018\u0000\u0096\u0097\u0003\u001a\r\u0000"+
		"\u0097\u000f\u0001\u0000\u0000\u0000\u0098\u0099\u0005\u0134\u0000\u0000"+
		"\u0099\u009a\u0005\u0184\u0000\u0000\u009a\u0011\u0001\u0000\u0000\u0000"+
		"\u009b\u009c\u0005\u0134\u0000\u0000\u009c\u009d\u0005\u0185\u0000\u0000"+
		"\u009d\u0013\u0001\u0000\u0000\u0000\u009e\u009f\u0005\u0134\u0000\u0000"+
		"\u009f\u00a0\u0005\u0186\u0000\u0000\u00a0\u0015\u0001\u0000\u0000\u0000"+
		"\u00a1\u00a2\u0005\u0134\u0000\u0000\u00a2\u00a3\u0005\u0187\u0000\u0000"+
		"\u00a3\u0017\u0001\u0000\u0000\u0000\u00a4\u00a5\u0005\u0198\u0000\u0000"+
		"\u00a5\u0019\u0001\u0000\u0000\u0000\u00a6\u00a9\u0003L&\u0000\u00a7\u00a9"+
		"\u0003\u0002\u0001\u0000\u00a8\u00a6\u0001\u0000\u0000\u0000\u00a8\u00a7"+
		"\u0001\u0000\u0000\u0000\u00a9\u00ac\u0001\u0000\u0000\u0000\u00aa\u00a8"+
		"\u0001\u0000\u0000\u0000\u00aa\u00ab\u0001\u0000\u0000\u0000\u00ab\u001b"+
		"\u0001\u0000\u0000\u0000\u00ac\u00aa\u0001\u0000\u0000\u0000\u00ad\u00ae"+
		"\u0005\u016e\u0000\u0000\u00ae\u001d\u0001\u0000\u0000\u0000\u00af\u00b0"+
		"\u0005\u0134\u0000\u0000\u00b0\u00b1\u0005\u0188\u0000\u0000\u00b1\u00b2"+
		"\u00030\u0018\u0000\u00b2\u00b6\u0003\u001a\r\u0000\u00b3\u00b5\u0003"+
		"\u000e\u0007\u0000\u00b4\u00b3\u0001\u0000\u0000\u0000\u00b5\u00b8\u0001"+
		"\u0000\u0000\u0000\u00b6\u00b4\u0001\u0000\u0000\u0000\u00b6\u00b7\u0001"+
		"\u0000\u0000\u0000\u00b7\u00ba\u0001\u0000\u0000\u0000\u00b8\u00b6\u0001"+
		"\u0000\u0000\u0000\u00b9\u00bb\u0003\f\u0006\u0000\u00ba\u00b9\u0001\u0000"+
		"\u0000\u0000\u00ba\u00bb\u0001\u0000\u0000\u0000\u00bb\u00bc\u0001\u0000"+
		"\u0000\u0000\u00bc\u00bd\u0003\u0014\n\u0000\u00bd\u001f\u0001\u0000\u0000"+
		"\u0000\u00be\u00bf\u0005\u0134\u0000\u0000\u00bf\u00c0\u0005\u0189\u0000"+
		"\u0000\u00c0\u00c1\u00030\u0018\u0000\u00c1\u00c5\u0003\u001a\r\u0000"+
		"\u00c2\u00c4\u0003\u000e\u0007\u0000\u00c3\u00c2\u0001\u0000\u0000\u0000"+
		"\u00c4\u00c7\u0001\u0000\u0000\u0000\u00c5\u00c3\u0001\u0000\u0000\u0000"+
		"\u00c5\u00c6\u0001\u0000\u0000\u0000\u00c6\u00c9\u0001\u0000\u0000\u0000"+
		"\u00c7\u00c5\u0001\u0000\u0000\u0000\u00c8\u00ca\u0003\f\u0006\u0000\u00c9"+
		"\u00c8\u0001\u0000\u0000\u0000\u00c9\u00ca\u0001\u0000\u0000\u0000\u00ca"+
		"\u00cb\u0001\u0000\u0000\u0000\u00cb\u00cc\u0003\u0014\n\u0000\u00cc!"+
		"\u0001\u0000\u0000\u0000\u00cd\u00ce\u0005\u0134\u0000\u0000\u00ce\u00d8"+
		"\u0005\u018a\u0000\u0000\u00cf\u00d0\u0005\u0128\u0000\u0000\u00d0\u00d1"+
		"\u0003\u0018\f\u0000\u00d1\u00d2\u0005\u0128\u0000\u0000\u00d2\u00d9\u0001"+
		"\u0000\u0000\u0000\u00d3\u00d4\u0005\u0142\u0000\u0000\u00d4\u00d5\u0003"+
		"\u0018\f\u0000\u00d5\u00d6\u0005\u0135\u0000\u0000\u00d6\u00d9\u0001\u0000"+
		"\u0000\u0000\u00d7\u00d9\u0003R)\u0000\u00d8\u00cf\u0001\u0000\u0000\u0000"+
		"\u00d8\u00d3\u0001\u0000\u0000\u0000\u00d8\u00d7\u0001\u0000\u0000\u0000"+
		"\u00d9#\u0001\u0000\u0000\u0000\u00da\u00db\u0005\u0173\u0000\u0000\u00db"+
		"%\u0001\u0000\u0000\u0000\u00dc\u00dd\u0005\u0134\u0000\u0000\u00dd\u00de"+
		"\u0005\u018b\u0000\u0000\u00de\u00df\u0003>\u001f\u0000\u00df\u00e0\u0005"+
		"\u0128\u0000\u0000\u00e0\u00e1\u0003\u0018\f\u0000\u00e1\u00e2\u0005\u0128"+
		"\u0000\u0000\u00e2\u00e3\u0003$\u0012\u0000\u00e3\'\u0001\u0000\u0000"+
		"\u0000\u00e4\u00e5\u0005\u0134\u0000\u0000\u00e5\u00e6\u0005\u018c\u0000"+
		"\u0000\u00e6)\u0001\u0000\u0000\u0000\u00e7\u00e8\u0005\u0199\u0000\u0000"+
		"\u00e8+\u0001\u0000\u0000\u0000\u00e9\u00ea\u0005\u019a\u0000\u0000\u00ea"+
		"-\u0001\u0000\u0000\u0000\u00eb\u00ec\u0005\u019b\u0000\u0000\u00ec/\u0001"+
		"\u0000\u0000\u0000\u00ed\u00ee\u0005\u01a2\u0000\u0000\u00ee1\u0001\u0000"+
		"\u0000\u0000\u00ef\u00f0\u0005\u0197\u0000\u0000\u00f03\u0001\u0000\u0000"+
		"\u0000\u00f1\u00f2\u0005\u019c\u0000\u0000\u00f25\u0001\u0000\u0000\u0000"+
		"\u00f3\u00fa\u00038\u001c\u0000\u00f4\u00fa\u0003*\u0015\u0000\u00f5\u00fa"+
		"\u0003,\u0016\u0000\u00f6\u00fa\u0003.\u0017\u0000\u00f7\u00fa\u00034"+
		"\u001a\u0000\u00f8\u00fa\u0003N\'\u0000\u00f9\u00f3\u0001\u0000\u0000"+
		"\u0000\u00f9\u00f4\u0001\u0000\u0000\u0000\u00f9\u00f5\u0001\u0000\u0000"+
		"\u0000\u00f9\u00f6\u0001\u0000\u0000\u0000\u00f9\u00f7\u0001\u0000\u0000"+
		"\u0000\u00f9\u00f8\u0001\u0000\u0000\u0000\u00fa\u00fd\u0001\u0000\u0000"+
		"\u0000\u00fb\u00f9\u0001\u0000\u0000\u0000\u00fb\u00fc\u0001\u0000\u0000"+
		"\u0000\u00fc7\u0001\u0000\u0000\u0000\u00fd\u00fb\u0001\u0000\u0000\u0000"+
		"\u00fe\u00ff\u0005\u019d\u0000\u0000\u00ff9\u0001\u0000\u0000\u0000\u0100"+
		"\u0101\u0005\u0194\u0000\u0000\u0101;\u0001\u0000\u0000\u0000\u0102\u0103"+
		"\u0005\u0134\u0000\u0000\u0103\u0104\u0005\u018d\u0000\u0000\u0104=\u0001"+
		"\u0000\u0000\u0000\u0105\u0106\u0005\u0173\u0000\u0000\u0106?\u0001\u0000"+
		"\u0000\u0000\u0107\u0108\u0005\u0134\u0000\u0000\u0108\u0109\u0005\u018e"+
		"\u0000\u0000\u0109\u0112\u0003F#\u0000\u010a\u010f\u0003B!\u0000\u010b"+
		"\u010c\u0005\u0126\u0000\u0000\u010c\u010e\u0003B!\u0000\u010d\u010b\u0001"+
		"\u0000\u0000\u0000\u010e\u0111\u0001\u0000\u0000\u0000\u010f\u010d\u0001"+
		"\u0000\u0000\u0000\u010f\u0110\u0001\u0000\u0000\u0000\u0110\u0113\u0001"+
		"\u0000\u0000\u0000\u0111\u010f\u0001\u0000\u0000\u0000\u0112\u010a\u0001"+
		"\u0000\u0000\u0000\u0112\u0113\u0001\u0000\u0000\u0000\u0113A\u0001\u0000"+
		"\u0000\u0000\u0114\u0115\u0003D\"\u0000\u0115\u0116\u0005\u012f\u0000"+
		"\u0000\u0116\u0118\u0001\u0000\u0000\u0000\u0117\u0114\u0001\u0000\u0000"+
		"\u0000\u0117\u0118\u0001\u0000\u0000\u0000\u0118\u0119\u0001\u0000\u0000"+
		"\u0000\u0119\u011a\u0003H$\u0000\u011aC\u0001\u0000\u0000\u0000\u011b"+
		"\u011c\u0005\u016e\u0000\u0000\u011cE\u0001\u0000\u0000\u0000\u011d\u011e"+
		"\u0005\u016e\u0000\u0000\u011eG\u0001\u0000\u0000\u0000\u011f\u0120\u0005"+
		"\u0141\u0000\u0000\u0120\u0125\u0003B!\u0000\u0121\u0122\u0005\u0126\u0000"+
		"\u0000\u0122\u0124\u0003B!\u0000\u0123\u0121\u0001\u0000\u0000\u0000\u0124"+
		"\u0127\u0001\u0000\u0000\u0000\u0125\u0123\u0001\u0000\u0000\u0000\u0125"+
		"\u0126\u0001\u0000\u0000\u0000\u0126\u0128\u0001\u0000\u0000\u0000\u0127"+
		"\u0125\u0001\u0000\u0000\u0000\u0128\u0129\u0005\u0158\u0000\u0000\u0129"+
		"\u012e\u0001\u0000\u0000\u0000\u012a\u012e\u0003>\u001f\u0000\u012b\u012e"+
		"\u0003N\'\u0000\u012c\u012e\u0003\u001c\u000e\u0000\u012d\u011f\u0001"+
		"\u0000\u0000\u0000\u012d\u012a\u0001\u0000\u0000\u0000\u012d\u012b\u0001"+
		"\u0000\u0000\u0000\u012d\u012c\u0001\u0000\u0000\u0000\u012eI\u0001\u0000"+
		"\u0000\u0000\u012f\u0130\u0005\u0134\u0000\u0000\u0130\u0131\u0005\u018f"+
		"\u0000\u0000\u0131K\u0001\u0000\u0000\u0000\u0132\u0133\u0005\u019e\u0000"+
		"\u0000\u0133M\u0001\u0000\u0000\u0000\u0134\u0135\u0005\u016f\u0000\u0000"+
		"\u0135O\u0001\u0000\u0000\u0000\u0136\u0137\u0005\u0134\u0000\u0000\u0137"+
		"\u0138\u0005\u0181\u0000\u0000\u0138\u0139\u00032\u0019\u0000\u0139\u013a"+
		"\u00036\u001b\u0000\u013aQ\u0001\u0000\u0000\u0000\u013b\u013c\u0005\u0134"+
		"\u0000\u0000\u013c\u013d\u0003:\u001d\u0000\u013dS\u0001\u0000\u0000\u0000"+
		"\u013e\u013f\u0005\u01a0\u0000\u0000\u013f\u0140\u0005\u019f\u0000\u0000"+
		"\u0140U\u0001\u0000\u0000\u0000\u0141\u0142\u0005\u01a0\u0000\u0000\u0142"+
		"\u0143\u0005\u019f\u0000\u0000\u0143W\u0001\u0000\u0000\u0000\u0144\u0145"+
		"\u0005\u0134\u0000\u0000\u0145\u0146\u0005\u0190\u0000\u0000\u0146\u0147"+
		"\u0003V+\u0000\u0147\u0148\u0005\u015a\u0000\u0000\u0148\u0149\u0003T"+
		"*\u0000\u0149Y\u0001\u0000\u0000\u0000\u014a\u014b\u0005\u0134\u0000\u0000"+
		"\u014b\u014c\u0005\u0191\u0000\u0000\u014c\u014d\u0003\\.\u0000\u014d"+
		"[\u0001\u0000\u0000\u0000\u014e\u014f\u0005\u01a1\u0000\u0000\u014f]\u0001"+
		"\u0000\u0000\u0000\u0150\u0151\u0005\u0134\u0000\u0000\u0151\u0152\u0005"+
		"\u0192\u0000\u0000\u0152\u0153\u00030\u0018\u0000\u0153_\u0001\u0000\u0000"+
		"\u0000\u0154\u0155\u0005\u0134\u0000\u0000\u0155\u0156\u0005\u0193\u0000"+
		"\u0000\u0156a\u0001\u0000\u0000\u0000\u0157\u0158\u0005\u0195\u0000\u0000"+
		"\u0158c\u0001\u0000\u0000\u0000\u0010g~\u00a8\u00aa\u00b6\u00ba\u00c5"+
		"\u00c9\u00d8\u00f9\u00fb\u010f\u0112\u0117\u0125\u012d";
	public static final ATN _ATN =
		new ATNDeserializer().deserialize(_serializedATN.toCharArray());
	static {
		_decisionToDFA = new DFA[_ATN.getNumberOfDecisions()];
		for (int i = 0; i < _ATN.getNumberOfDecisions(); i++) {
			_decisionToDFA[i] = new DFA(_ATN.getDecisionState(i), i);
		}
	}
}