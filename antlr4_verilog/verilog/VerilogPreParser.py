# Generated from VerilogPreParser.g4 by ANTLR 4.7.2
# encoding: utf-8
from antlr4 import *
from io import StringIO
from typing.io import TextIO
import sys

def serializedATN():
    with StringIO() as buf:
        buf.write("\3\u608b\ua72a\u8133\ub9ed\u417c\u3be7\u7786\u5964\3\u00f7")
        buf.write("\u0143\4\2\t\2\4\3\t\3\4\4\t\4\4\5\t\5\4\6\t\6\4\7\t\7")
        buf.write("\4\b\t\b\4\t\t\t\4\n\t\n\4\13\t\13\4\f\t\f\4\r\t\r\4\16")
        buf.write("\t\16\4\17\t\17\4\20\t\20\4\21\t\21\4\22\t\22\4\23\t\23")
        buf.write("\4\24\t\24\4\25\t\25\4\26\t\26\4\27\t\27\4\30\t\30\4\31")
        buf.write("\t\31\4\32\t\32\4\33\t\33\4\34\t\34\4\35\t\35\4\36\t\36")
        buf.write("\4\37\t\37\4 \t \4!\t!\4\"\t\"\4#\t#\4$\t$\4%\t%\4&\t")
        buf.write("&\4\'\t\'\4(\t(\4)\t)\4*\t*\4+\t+\4,\t,\4-\t-\4.\t.\4")
        buf.write("/\t/\4\60\t\60\3\2\7\2b\n\2\f\2\16\2e\13\2\3\3\3\3\3\3")
        buf.write("\3\3\3\3\3\3\3\3\3\3\3\3\3\3\3\3\3\3\3\3\3\3\3\3\3\3\3")
        buf.write("\3\5\3x\n\3\3\4\3\4\3\4\3\4\3\4\3\4\3\5\3\5\3\5\3\6\3")
        buf.write("\6\3\6\3\6\3\7\3\7\3\b\3\b\3\b\3\b\3\t\3\t\3\t\3\t\3\t")
        buf.write("\3\n\3\n\3\n\3\13\3\13\3\13\3\f\3\f\3\f\3\r\3\r\3\16\3")
        buf.write("\16\7\16\u009f\n\16\f\16\16\16\u00a2\13\16\3\17\3\17\3")
        buf.write("\20\3\20\3\20\3\20\3\20\7\20\u00ab\n\20\f\20\16\20\u00ae")
        buf.write("\13\20\3\20\5\20\u00b1\n\20\3\20\3\20\3\21\3\21\3\21\3")
        buf.write("\21\3\21\7\21\u00ba\n\21\f\21\16\21\u00bd\13\21\3\21\5")
        buf.write("\21\u00c0\n\21\3\21\3\21\3\22\3\22\3\22\3\22\3\22\3\22")
        buf.write("\3\23\3\23\3\24\3\24\3\24\3\24\3\24\3\24\3\24\3\24\3\25")
        buf.write("\3\25\3\26\3\26\3\27\3\27\3\30\3\30\3\31\3\31\3\32\3\32")
        buf.write("\3\33\3\33\3\33\3\33\3\33\3\33\7\33\u00e6\n\33\f\33\16")
        buf.write("\33\u00e9\13\33\3\34\3\34\3\35\3\35\3\36\3\36\3\36\3\37")
        buf.write("\3\37\3 \3 \3 \3 \3 \3 \7 \u00fa\n \f \16 \u00fd\13 \5")
        buf.write(" \u00ff\n \3!\3!\3!\5!\u0104\n!\3!\3!\3\"\3\"\3#\3#\3")
        buf.write("$\3$\3$\3$\7$\u0110\n$\f$\16$\u0113\13$\3$\3$\3$\3$\3")
        buf.write("$\5$\u011a\n$\3%\3%\3%\3&\3&\3\'\3\'\3(\3(\3(\3(\3(\3")
        buf.write(")\3)\3)\3*\3*\3*\3+\3+\3+\3,\3,\3,\3,\3,\3,\3-\3-\3-\3")
        buf.write("-\3.\3.\3/\3/\3/\3/\3\60\3\60\3\60\2\2\61\2\4\6\b\n\f")
        buf.write("\16\20\22\24\26\30\32\34\36 \"$&(*,.\60\62\64\668:<>@")
        buf.write("BDFHJLNPRTVXZ\\^\2\2\2\u0137\2c\3\2\2\2\4w\3\2\2\2\6y")
        buf.write("\3\2\2\2\b\177\3\2\2\2\n\u0082\3\2\2\2\f\u0086\3\2\2\2")
        buf.write("\16\u0088\3\2\2\2\20\u008c\3\2\2\2\22\u0091\3\2\2\2\24")
        buf.write("\u0094\3\2\2\2\26\u0097\3\2\2\2\30\u009a\3\2\2\2\32\u00a0")
        buf.write("\3\2\2\2\34\u00a3\3\2\2\2\36\u00a5\3\2\2\2 \u00b4\3\2")
        buf.write("\2\2\"\u00c3\3\2\2\2$\u00c9\3\2\2\2&\u00cb\3\2\2\2(\u00d3")
        buf.write("\3\2\2\2*\u00d5\3\2\2\2,\u00d7\3\2\2\2.\u00d9\3\2\2\2")
        buf.write("\60\u00db\3\2\2\2\62\u00dd\3\2\2\2\64\u00e7\3\2\2\2\66")
        buf.write("\u00ea\3\2\2\28\u00ec\3\2\2\2:\u00ee\3\2\2\2<\u00f1\3")
        buf.write("\2\2\2>\u00f3\3\2\2\2@\u0103\3\2\2\2B\u0107\3\2\2\2D\u0109")
        buf.write("\3\2\2\2F\u0119\3\2\2\2H\u011b\3\2\2\2J\u011e\3\2\2\2")
        buf.write("L\u0120\3\2\2\2N\u0122\3\2\2\2P\u0127\3\2\2\2R\u012a\3")
        buf.write("\2\2\2T\u012d\3\2\2\2V\u0130\3\2\2\2X\u0136\3\2\2\2Z\u013a")
        buf.write("\3\2\2\2\\\u013c\3\2\2\2^\u0140\3\2\2\2`b\5\4\3\2a`\3")
        buf.write("\2\2\2be\3\2\2\2ca\3\2\2\2cd\3\2\2\2d\3\3\2\2\2ec\3\2")
        buf.write("\2\2fx\5\6\4\2gx\5\b\5\2hx\5\n\6\2ix\5\22\n\2jx\5\24\13")
        buf.write("\2kx\5\36\20\2lx\5 \21\2mx\5\"\22\2nx\5&\24\2ox\5:\36")
        buf.write("\2px\5> \2qx\5H%\2rx\5N(\2sx\5P)\2tx\5V,\2ux\5X-\2vx\5")
        buf.write("\\/\2wf\3\2\2\2wg\3\2\2\2wh\3\2\2\2wi\3\2\2\2wj\3\2\2")
        buf.write("\2wk\3\2\2\2wl\3\2\2\2wm\3\2\2\2wn\3\2\2\2wo\3\2\2\2w")
        buf.write("p\3\2\2\2wq\3\2\2\2wr\3\2\2\2ws\3\2\2\2wt\3\2\2\2wu\3")
        buf.write("\2\2\2wv\3\2\2\2x\5\3\2\2\2yz\7\u00a0\2\2z{\7\u00d6\2")
        buf.write("\2{|\7\u0097\2\2|}\5^\60\2}~\7\u0097\2\2~\7\3\2\2\2\177")
        buf.write("\u0080\7\u00a0\2\2\u0080\u0081\7\u00d7\2\2\u0081\t\3\2")
        buf.write("\2\2\u0082\u0083\7\u00a0\2\2\u0083\u0084\7\u00d8\2\2\u0084")
        buf.write("\u0085\5\f\7\2\u0085\13\3\2\2\2\u0086\u0087\7\u00eb\2")
        buf.write("\2\u0087\r\3\2\2\2\u0088\u0089\7\u00a0\2\2\u0089\u008a")
        buf.write("\7\u00da\2\2\u008a\u008b\5\32\16\2\u008b\17\3\2\2\2\u008c")
        buf.write("\u008d\7\u00a0\2\2\u008d\u008e\7\u00db\2\2\u008e\u008f")
        buf.write("\5.\30\2\u008f\u0090\5\32\16\2\u0090\21\3\2\2\2\u0091")
        buf.write("\u0092\7\u00a0\2\2\u0092\u0093\7\u00dc\2\2\u0093\23\3")
        buf.write("\2\2\2\u0094\u0095\7\u00a0\2\2\u0095\u0096\7\u00dd\2\2")
        buf.write("\u0096\25\3\2\2\2\u0097\u0098\7\u00a0\2\2\u0098\u0099")
        buf.write("\7\u00de\2\2\u0099\27\3\2\2\2\u009a\u009b\7\u00ed\2\2")
        buf.write("\u009b\31\3\2\2\2\u009c\u009f\5J&\2\u009d\u009f\5\4\3")
        buf.write("\2\u009e\u009c\3\2\2\2\u009e\u009d\3\2\2\2\u009f\u00a2")
        buf.write("\3\2\2\2\u00a0\u009e\3\2\2\2\u00a0\u00a1\3\2\2\2\u00a1")
        buf.write("\33\3\2\2\2\u00a2\u00a0\3\2\2\2\u00a3\u00a4\7\u00c8\2")
        buf.write("\2\u00a4\35\3\2\2\2\u00a5\u00a6\7\u00a0\2\2\u00a6\u00a7")
        buf.write("\7\u00df\2\2\u00a7\u00a8\5.\30\2\u00a8\u00ac\5\32\16\2")
        buf.write("\u00a9\u00ab\5\20\t\2\u00aa\u00a9\3\2\2\2\u00ab\u00ae")
        buf.write("\3\2\2\2\u00ac\u00aa\3\2\2\2\u00ac\u00ad\3\2\2\2\u00ad")
        buf.write("\u00b0\3\2\2\2\u00ae\u00ac\3\2\2\2\u00af\u00b1\5\16\b")
        buf.write("\2\u00b0\u00af\3\2\2\2\u00b0\u00b1\3\2\2\2\u00b1\u00b2")
        buf.write("\3\2\2\2\u00b2\u00b3\5\26\f\2\u00b3\37\3\2\2\2\u00b4\u00b5")
        buf.write("\7\u00a0\2\2\u00b5\u00b6\7\u00e0\2\2\u00b6\u00b7\5.\30")
        buf.write("\2\u00b7\u00bb\5\32\16\2\u00b8\u00ba\5\20\t\2\u00b9\u00b8")
        buf.write("\3\2\2\2\u00ba\u00bd\3\2\2\2\u00bb\u00b9\3\2\2\2\u00bb")
        buf.write("\u00bc\3\2\2\2\u00bc\u00bf\3\2\2\2\u00bd\u00bb\3\2\2\2")
        buf.write("\u00be\u00c0\5\16\b\2\u00bf\u00be\3\2\2\2\u00bf\u00c0")
        buf.write("\3\2\2\2\u00c0\u00c1\3\2\2\2\u00c1\u00c2\5\26\f\2\u00c2")
        buf.write("!\3\2\2\2\u00c3\u00c4\7\u00a0\2\2\u00c4\u00c5\7\u00e1")
        buf.write("\2\2\u00c5\u00c6\7\u0097\2\2\u00c6\u00c7\5\30\r\2\u00c7")
        buf.write("\u00c8\7\u0097\2\2\u00c8#\3\2\2\2\u00c9\u00ca\7\u00cb")
        buf.write("\2\2\u00ca%\3\2\2\2\u00cb\u00cc\7\u00a0\2\2\u00cc\u00cd")
        buf.write("\7\u00e2\2\2\u00cd\u00ce\5<\37\2\u00ce\u00cf\7\u0097\2")
        buf.write("\2\u00cf\u00d0\5\30\r\2\u00d0\u00d1\7\u0097\2\2\u00d1")
        buf.write("\u00d2\5$\23\2\u00d2\'\3\2\2\2\u00d3\u00d4\7\u00ee\2\2")
        buf.write("\u00d4)\3\2\2\2\u00d5\u00d6\7\u00ef\2\2\u00d6+\3\2\2\2")
        buf.write("\u00d7\u00d8\7\u00f0\2\2\u00d8-\3\2\2\2\u00d9\u00da\7")
        buf.write("\u00f7\2\2\u00da/\3\2\2\2\u00db\u00dc\7\u00ec\2\2\u00dc")
        buf.write("\61\3\2\2\2\u00dd\u00de\7\u00f1\2\2\u00de\63\3\2\2\2\u00df")
        buf.write("\u00e6\5\66\34\2\u00e0\u00e6\5(\25\2\u00e1\u00e6\5*\26")
        buf.write("\2\u00e2\u00e6\5,\27\2\u00e3\u00e6\5\62\32\2\u00e4\u00e6")
        buf.write("\5L\'\2\u00e5\u00df\3\2\2\2\u00e5\u00e0\3\2\2\2\u00e5")
        buf.write("\u00e1\3\2\2\2\u00e5\u00e2\3\2\2\2\u00e5\u00e3\3\2\2\2")
        buf.write("\u00e5\u00e4\3\2\2\2\u00e6\u00e9\3\2\2\2\u00e7\u00e5\3")
        buf.write("\2\2\2\u00e7\u00e8\3\2\2\2\u00e8\65\3\2\2\2\u00e9\u00e7")
        buf.write("\3\2\2\2\u00ea\u00eb\7\u00f2\2\2\u00eb\67\3\2\2\2\u00ec")
        buf.write("\u00ed\7\u00e9\2\2\u00ed9\3\2\2\2\u00ee\u00ef\7\u00a0")
        buf.write("\2\2\u00ef\u00f0\7\u00e3\2\2\u00f0;\3\2\2\2\u00f1\u00f2")
        buf.write("\7\u00cb\2\2\u00f2=\3\2\2\2\u00f3\u00f4\7\u00a0\2\2\u00f4")
        buf.write("\u00f5\7\u00e4\2\2\u00f5\u00fe\5D#\2\u00f6\u00fb\5@!\2")
        buf.write("\u00f7\u00f8\7\u0095\2\2\u00f8\u00fa\5@!\2\u00f9\u00f7")
        buf.write("\3\2\2\2\u00fa\u00fd\3\2\2\2\u00fb\u00f9\3\2\2\2\u00fb")
        buf.write("\u00fc\3\2\2\2\u00fc\u00ff\3\2\2\2\u00fd\u00fb\3\2\2\2")
        buf.write("\u00fe\u00f6\3\2\2\2\u00fe\u00ff\3\2\2\2\u00ff?\3\2\2")
        buf.write("\2\u0100\u0101\5B\"\2\u0101\u0102\7\u009c\2\2\u0102\u0104")
        buf.write("\3\2\2\2\u0103\u0100\3\2\2\2\u0103\u0104\3\2\2\2\u0104")
        buf.write("\u0105\3\2\2\2\u0105\u0106\5F$\2\u0106A\3\2\2\2\u0107")
        buf.write("\u0108\7\u00c8\2\2\u0108C\3\2\2\2\u0109\u010a\7\u00c8")
        buf.write("\2\2\u010aE\3\2\2\2\u010b\u010c\7\u00a8\2\2\u010c\u0111")
        buf.write("\5@!\2\u010d\u010e\7\u0095\2\2\u010e\u0110\5@!\2\u010f")
        buf.write("\u010d\3\2\2\2\u0110\u0113\3\2\2\2\u0111\u010f\3\2\2\2")
        buf.write("\u0111\u0112\3\2\2\2\u0112\u0114\3\2\2\2\u0113\u0111\3")
        buf.write("\2\2\2\u0114\u0115\7\u00b6\2\2\u0115\u011a\3\2\2\2\u0116")
        buf.write("\u011a\5<\37\2\u0117\u011a\5L\'\2\u0118\u011a\5\34\17")
        buf.write("\2\u0119\u010b\3\2\2\2\u0119\u0116\3\2\2\2\u0119\u0117")
        buf.write("\3\2\2\2\u0119\u0118\3\2\2\2\u011aG\3\2\2\2\u011b\u011c")
        buf.write("\7\u00a0\2\2\u011c\u011d\7\u00e5\2\2\u011dI\3\2\2\2\u011e")
        buf.write("\u011f\7\u00f3\2\2\u011fK\3\2\2\2\u0120\u0121\7\u00c9")
        buf.write("\2\2\u0121M\3\2\2\2\u0122\u0123\7\u00a0\2\2\u0123\u0124")
        buf.write("\7\u00d9\2\2\u0124\u0125\5\60\31\2\u0125\u0126\5\64\33")
        buf.write("\2\u0126O\3\2\2\2\u0127\u0128\7\u00a0\2\2\u0128\u0129")
        buf.write("\58\35\2\u0129Q\3\2\2\2\u012a\u012b\7\u00f5\2\2\u012b")
        buf.write("\u012c\7\u00f4\2\2\u012cS\3\2\2\2\u012d\u012e\7\u00f5")
        buf.write("\2\2\u012e\u012f\7\u00f4\2\2\u012fU\3\2\2\2\u0130\u0131")
        buf.write("\7\u00a0\2\2\u0131\u0132\7\u00e6\2\2\u0132\u0133\5T+\2")
        buf.write("\u0133\u0134\7\u00b8\2\2\u0134\u0135\5R*\2\u0135W\3\2")
        buf.write("\2\2\u0136\u0137\7\u00a0\2\2\u0137\u0138\7\u00e7\2\2\u0138")
        buf.write("\u0139\5Z.\2\u0139Y\3\2\2\2\u013a\u013b\7\u00f6\2\2\u013b")
        buf.write("[\3\2\2\2\u013c\u013d\7\u00a0\2\2\u013d\u013e\7\u00e8")
        buf.write("\2\2\u013e\u013f\5.\30\2\u013f]\3\2\2\2\u0140\u0141\7")
        buf.write("\u00ea\2\2\u0141_\3\2\2\2\21cw\u009e\u00a0\u00ac\u00b0")
        buf.write("\u00bb\u00bf\u00e5\u00e7\u00fb\u00fe\u0103\u0111\u0119")
        return buf.getvalue()


class VerilogPreParser ( Parser ):

    grammarFileName = "VerilogPreParser.g4"

    atn = ATNDeserializer().deserialize(serializedATN())

    decisionsToDFA = [ DFA(ds, i) for i, ds in enumerate(atn.decisionToState) ]

    sharedContextCache = PredictionContextCache()

    literalNames = [ "<INVALID>", "'always'", "'and'", "'assign'", "'automatic'", 
                     "'begin'", "'buf'", "'bufif1'", "'bufif0'", "'case'", 
                     "'casex'", "'casez'", "'cell'", "'cmos'", "'config'", 
                     "'deassign'", "'default'", "'defparam'", "'design'", 
                     "'disable'", "'$fullskew'", "'$hold'", "'$nochange'", 
                     "'$period'", "'$recovery'", "'$recrem'", "'$removal'", 
                     "'$setup'", "'$setuphold'", "'$skew'", "'$timeskew'", 
                     "'$width'", "'edge'", "'else'", "'end'", "'endcase'", 
                     "'endconfig'", "'endfunction'", "'endgenerate'", "'endmodule'", 
                     "'endprimitive'", "'endspecify'", "'endtable'", "'endtask'", 
                     "'event'", "'for'", "'force'", "'forever'", "'fork'", 
                     "'function'", "'generate'", "'genvar'", "'highz1'", 
                     "'highz0'", "'if'", "'ifnone'", "'include'", "'initial'", 
                     "'inout'", "'input'", "'instance'", "'integer'", "'join'", 
                     "'large'", "'liblist'", "'library'", "'localparam'", 
                     "'macromodule'", "'medium'", "'-incdir'", "'module'", 
                     "'nand'", "'negedge'", "'nmos'", "'nor'", "'noshowcancelled'", 
                     "'not'", "'notif1'", "'notif0'", "'or'", "'output'", 
                     "'parameter'", "'PATHPULSE$'", "'pmos'", "'posedge'", 
                     "'primitive'", "'pulldown'", "'pull1'", "'pullup'", 
                     "'pull0'", "'pulsestyle_ondetect'", "'pulsestyle_onevent'", 
                     "'rcmos'", "'real'", "'realtime'", "'reg'", "'release'", 
                     "'repeat'", "'rnmos'", "'rpmos'", "'rtran'", "'rtranif1'", 
                     "'rtranif0'", "'scalared'", "'showcancelled'", "'signed'", 
                     "'small'", "'specify'", "'specparam'", "'strong1'", 
                     "'strong0'", "'supply1'", "'supply0'", "'table'", "'task'", 
                     "'time'", "'tran'", "'tranif1'", "'tranif0'", "'tri'", 
                     "'triand'", "'tri1'", "'trior'", "'trireg'", "'tri0'", 
                     "'use'", "'uwire'", "'vectored'", "'wait'", "'wand'", 
                     "'weak1'", "'weak0'", "'while'", "'wire'", "'wor'", 
                     "'xnor'", "'xor'", "'&'", "'&&'", "'&&&'", "'*'", "'**'", 
                     "'*>'", "'@'", "'^'", "'^~'", "':'", "','", "'$'", 
                     "'\"'", "'.'", "'!'", "'!='", "'!=='", "'='", "'=='", 
                     "'==='", "'=>'", "<INVALID>", "'>'", "'>='", "'>>'", 
                     "'>>>'", "'#'", "'['", "'{'", "'('", "'<'", "'<='", 
                     "'<<'", "'<<<'", "'-'", "'-:'", "'->'", "'%'", "'+'", 
                     "'+:'", "'?'", "']'", "'}'", "')'", "';'", "'/'", "'~'", 
                     "'~&'", "'~^'", "'~|'", "'|'", "'||'", "<INVALID>", 
                     "<INVALID>", "<INVALID>", "<INVALID>", "<INVALID>", 
                     "<INVALID>", "<INVALID>", "<INVALID>", "<INVALID>", 
                     "<INVALID>", "<INVALID>", "<INVALID>", "<INVALID>", 
                     "<INVALID>", "<INVALID>", "<INVALID>", "<INVALID>", 
                     "<INVALID>", "<INVALID>", "<INVALID>", "<INVALID>", 
                     "<INVALID>", "<INVALID>", "<INVALID>", "'celldefine'", 
                     "<INVALID>", "<INVALID>", "<INVALID>", "<INVALID>", 
                     "'end_keywords'", "'endcelldefine'", "<INVALID>", "<INVALID>", 
                     "<INVALID>", "<INVALID>", "<INVALID>", "'nounconnected_drive'", 
                     "<INVALID>", "'resetall'", "<INVALID>", "<INVALID>", 
                     "<INVALID>", "<INVALID>", "<INVALID>", "<INVALID>", 
                     "<INVALID>", "<INVALID>", "'``'", "<INVALID>", "'`\\`\"'", 
                     "'`\"'" ]

    symbolicNames = [ "<INVALID>", "ALWAYS", "AND", "ASSIGN", "AUTOMATIC", 
                      "BEGIN", "BUF", "BUFIFONE", "BUFIFZERO", "CASE", "CASEX", 
                      "CASEZ", "CELL", "CMOS", "CONFIG", "DEASSIGN", "DEFAULT", 
                      "DEFPARAM", "DESIGN", "DISABLE", "DLFULLSKEW", "DLHOLD", 
                      "DLNOCHANGE", "DLPERIOD", "DLRECOVERY", "DLRECREM", 
                      "DLREMOVAL", "DLSETUP", "DLSETUPHOLD", "DLSKEW", "DLTIMESKEW", 
                      "DLWIDTH", "EDGE", "ELSE", "END", "ENDCASE", "ENDCONFIG", 
                      "ENDFUNCTION", "ENDGENERATE", "ENDMODULE", "ENDPRIMITIVE", 
                      "ENDSPECIFY", "ENDTABLE", "ENDTASK", "EVENT", "FOR", 
                      "FORCE", "FOREVER", "FORK", "FUNCTION", "GENERATE", 
                      "GENVAR", "HIGHZONE", "HIGHZZERO", "IF", "IFNONE", 
                      "INCLUDE", "INITIAL", "INOUT", "INPUT", "INSTANCE", 
                      "INTEGER", "JOIN", "LARGE", "LIBLIST", "LIBRARY", 
                      "LOCALPARAM", "MACROMODULE", "MEDIUM", "MIINCDIR", 
                      "MODULE", "NAND", "NEGEDGE", "NMOS", "NOR", "NOSHOWCANCELLED", 
                      "NOT", "NOTIFONE", "NOTIFZERO", "OR", "OUTPUT", "PARAMETER", 
                      "PATHPULSEDL", "PMOS", "POSEDGE", "PRIMITIVE", "PULLDOWN", 
                      "PULLONE", "PULLUP", "PULLZERO", "PULSESTYLE_ONDETECT", 
                      "PULSESTYLE_ONEVENT", "RCMOS", "REAL", "REALTIME", 
                      "REG", "RELEASE", "REPEAT", "RNMOS", "RPMOS", "RTRAN", 
                      "RTRANIFONE", "RTRANIFZERO", "SCALARED", "SHOWCANCELLED", 
                      "SIGNED", "SMALL", "SPECIFY", "SPECPARAM", "STRONGONE", 
                      "STRONGZERO", "SUPPLYONE", "SUPPLYZERO", "TABLE", 
                      "TASK", "TIME", "TRAN", "TRANIFONE", "TRANIFZERO", 
                      "TRI", "TRIAND", "TRIONE", "TRIOR", "TRIREG", "TRIZERO", 
                      "USE", "UWIRE", "VECTORED", "WAIT", "WAND", "WEAKONE", 
                      "WEAKZERO", "WHILE", "WIRE", "WOR", "XNOR", "XOR", 
                      "AM", "AMAM", "AMAMAM", "AS", "ASAS", "ASGT", "AT", 
                      "CA", "CATI", "CL", "CO", "DL", "DQ", "DT", "EM", 
                      "EMEQ", "EMEQEQ", "EQ", "EQEQ", "EQEQEQ", "EQGT", 
                      "GA", "GT", "GTEQ", "GTGT", "GTGTGT", "HA", "LB", 
                      "LC", "LP", "LT", "LTEQ", "LTLT", "LTLTLT", "MI", 
                      "MICL", "MIGT", "MO", "PL", "PLCL", "QM", "RB", "RC", 
                      "RP", "SC", "SL", "TI", "TIAM", "TICA", "TIVL", "VL", 
                      "VLVL", "BINARY_BASE", "BLOCK_COMMENT", "DECIMAL_BASE", 
                      "ESCAPED_IDENTIFIER", "EXPONENTIAL_NUMBER", "FIXED_POINT_NUMBER", 
                      "HEX_BASE", "LINE_COMMENT", "OCTAL_BASE", "SIMPLE_IDENTIFIER", 
                      "STRING", "SYSTEM_TF_IDENTIFIER", "UNSIGNED_NUMBER", 
                      "WHITE_SPACE", "BINARY_VALUE", "X_OR_Z_UNDERSCORE", 
                      "EDGE_DESCRIPTOR", "HEX_VALUE", "FILE_PATH_SPEC", 
                      "OCTAL_VALUE", "EDGE_SYMBOL", "LEVEL_ONLY_SYMBOL", 
                      "OUTPUT_OR_LEVEL_SYMBOL", "BEGIN_KEYWORDS_DIRECTIVE", 
                      "CELLDEFINE_DIRECTIVE", "DEFAULT_NETTYPE_DIRECTIVE", 
                      "DEFINE_DIRECTIVE", "ELSE_DIRECTIVE", "ELSIF_DIRECTIVE", 
                      "END_KEYWORDS_DIRECTIVE", "ENDCELLDEFINE_DIRECTIVE", 
                      "ENDIF_DIRECTIVE", "IFDEF_DIRECTIVE", "IFNDEF_DIRECTIVE", 
                      "INCLUDE_DIRECTIVE", "LINE_DIRECTIVE", "NOUNCONNECTED_DRIVE_DIRECTIVE", 
                      "PRAGMA_DIRECTIVE", "RESETALL_DIRECTIVE", "TIMESCALE_DIRECTIVE", 
                      "UNCONNECTED_DRIVE_DIRECTIVE", "UNDEF_DIRECTIVE", 
                      "MACRO_USAGE", "VERSION_SPECIFIER", "DEFAULT_NETTYPE_VALUE", 
                      "MACRO_NAME", "FILENAME", "MACRO_DELIMITER", "MACRO_ESC_NEWLINE", 
                      "MACRO_ESC_QUOTE", "MACRO_QUOTE", "MACRO_TEXT", "SOURCE_TEXT", 
                      "TIME_UNIT", "TIME_VALUE", "UNCONNECTED_DRIVE_VALUE", 
                      "MACRO_IDENTIFIER" ]

    RULE_source_text = 0
    RULE_compiler_directive = 1
    RULE_begin_keywords_directive = 2
    RULE_celldefine_directive = 3
    RULE_default_nettype_directive = 4
    RULE_default_nettype_value = 5
    RULE_else_directive = 6
    RULE_elsif_directive = 7
    RULE_end_keywords_directive = 8
    RULE_endcelldefine_directive = 9
    RULE_endif_directive = 10
    RULE_filename = 11
    RULE_group_of_lines = 12
    RULE_identifier = 13
    RULE_ifdef_directive = 14
    RULE_ifndef_directive = 15
    RULE_include_directive = 16
    RULE_level = 17
    RULE_line_directive = 18
    RULE_macro_delimiter = 19
    RULE_macro_esc_newline = 20
    RULE_macro_esc_quote = 21
    RULE_macro_identifier = 22
    RULE_macro_name = 23
    RULE_macro_quote = 24
    RULE_macro_text = 25
    RULE_macro_text_ = 26
    RULE_macro_usage = 27
    RULE_nounconnected_drive_directive = 28
    RULE_number = 29
    RULE_pragma_directive = 30
    RULE_pragma_expression = 31
    RULE_pragma_keyword = 32
    RULE_pragma_name = 33
    RULE_pragma_value = 34
    RULE_resetall_directive = 35
    RULE_source_text_ = 36
    RULE_string_ = 37
    RULE_text_macro_definition = 38
    RULE_text_macro_usage = 39
    RULE_time_precision = 40
    RULE_time_unit = 41
    RULE_timescale_directive = 42
    RULE_unconnected_drive_directive = 43
    RULE_unconnected_drive_value = 44
    RULE_undef_directive = 45
    RULE_version_specifier = 46

    ruleNames =  [ "source_text", "compiler_directive", "begin_keywords_directive", 
                   "celldefine_directive", "default_nettype_directive", 
                   "default_nettype_value", "else_directive", "elsif_directive", 
                   "end_keywords_directive", "endcelldefine_directive", 
                   "endif_directive", "filename", "group_of_lines", "identifier", 
                   "ifdef_directive", "ifndef_directive", "include_directive", 
                   "level", "line_directive", "macro_delimiter", "macro_esc_newline", 
                   "macro_esc_quote", "macro_identifier", "macro_name", 
                   "macro_quote", "macro_text", "macro_text_", "macro_usage", 
                   "nounconnected_drive_directive", "number", "pragma_directive", 
                   "pragma_expression", "pragma_keyword", "pragma_name", 
                   "pragma_value", "resetall_directive", "source_text_", 
                   "string_", "text_macro_definition", "text_macro_usage", 
                   "time_precision", "time_unit", "timescale_directive", 
                   "unconnected_drive_directive", "unconnected_drive_value", 
                   "undef_directive", "version_specifier" ]

    EOF = Token.EOF
    ALWAYS=1
    AND=2
    ASSIGN=3
    AUTOMATIC=4
    BEGIN=5
    BUF=6
    BUFIFONE=7
    BUFIFZERO=8
    CASE=9
    CASEX=10
    CASEZ=11
    CELL=12
    CMOS=13
    CONFIG=14
    DEASSIGN=15
    DEFAULT=16
    DEFPARAM=17
    DESIGN=18
    DISABLE=19
    DLFULLSKEW=20
    DLHOLD=21
    DLNOCHANGE=22
    DLPERIOD=23
    DLRECOVERY=24
    DLRECREM=25
    DLREMOVAL=26
    DLSETUP=27
    DLSETUPHOLD=28
    DLSKEW=29
    DLTIMESKEW=30
    DLWIDTH=31
    EDGE=32
    ELSE=33
    END=34
    ENDCASE=35
    ENDCONFIG=36
    ENDFUNCTION=37
    ENDGENERATE=38
    ENDMODULE=39
    ENDPRIMITIVE=40
    ENDSPECIFY=41
    ENDTABLE=42
    ENDTASK=43
    EVENT=44
    FOR=45
    FORCE=46
    FOREVER=47
    FORK=48
    FUNCTION=49
    GENERATE=50
    GENVAR=51
    HIGHZONE=52
    HIGHZZERO=53
    IF=54
    IFNONE=55
    INCLUDE=56
    INITIAL=57
    INOUT=58
    INPUT=59
    INSTANCE=60
    INTEGER=61
    JOIN=62
    LARGE=63
    LIBLIST=64
    LIBRARY=65
    LOCALPARAM=66
    MACROMODULE=67
    MEDIUM=68
    MIINCDIR=69
    MODULE=70
    NAND=71
    NEGEDGE=72
    NMOS=73
    NOR=74
    NOSHOWCANCELLED=75
    NOT=76
    NOTIFONE=77
    NOTIFZERO=78
    OR=79
    OUTPUT=80
    PARAMETER=81
    PATHPULSEDL=82
    PMOS=83
    POSEDGE=84
    PRIMITIVE=85
    PULLDOWN=86
    PULLONE=87
    PULLUP=88
    PULLZERO=89
    PULSESTYLE_ONDETECT=90
    PULSESTYLE_ONEVENT=91
    RCMOS=92
    REAL=93
    REALTIME=94
    REG=95
    RELEASE=96
    REPEAT=97
    RNMOS=98
    RPMOS=99
    RTRAN=100
    RTRANIFONE=101
    RTRANIFZERO=102
    SCALARED=103
    SHOWCANCELLED=104
    SIGNED=105
    SMALL=106
    SPECIFY=107
    SPECPARAM=108
    STRONGONE=109
    STRONGZERO=110
    SUPPLYONE=111
    SUPPLYZERO=112
    TABLE=113
    TASK=114
    TIME=115
    TRAN=116
    TRANIFONE=117
    TRANIFZERO=118
    TRI=119
    TRIAND=120
    TRIONE=121
    TRIOR=122
    TRIREG=123
    TRIZERO=124
    USE=125
    UWIRE=126
    VECTORED=127
    WAIT=128
    WAND=129
    WEAKONE=130
    WEAKZERO=131
    WHILE=132
    WIRE=133
    WOR=134
    XNOR=135
    XOR=136
    AM=137
    AMAM=138
    AMAMAM=139
    AS=140
    ASAS=141
    ASGT=142
    AT=143
    CA=144
    CATI=145
    CL=146
    CO=147
    DL=148
    DQ=149
    DT=150
    EM=151
    EMEQ=152
    EMEQEQ=153
    EQ=154
    EQEQ=155
    EQEQEQ=156
    EQGT=157
    GA=158
    GT=159
    GTEQ=160
    GTGT=161
    GTGTGT=162
    HA=163
    LB=164
    LC=165
    LP=166
    LT=167
    LTEQ=168
    LTLT=169
    LTLTLT=170
    MI=171
    MICL=172
    MIGT=173
    MO=174
    PL=175
    PLCL=176
    QM=177
    RB=178
    RC=179
    RP=180
    SC=181
    SL=182
    TI=183
    TIAM=184
    TICA=185
    TIVL=186
    VL=187
    VLVL=188
    BINARY_BASE=189
    BLOCK_COMMENT=190
    DECIMAL_BASE=191
    ESCAPED_IDENTIFIER=192
    EXPONENTIAL_NUMBER=193
    FIXED_POINT_NUMBER=194
    HEX_BASE=195
    LINE_COMMENT=196
    OCTAL_BASE=197
    SIMPLE_IDENTIFIER=198
    STRING=199
    SYSTEM_TF_IDENTIFIER=200
    UNSIGNED_NUMBER=201
    WHITE_SPACE=202
    BINARY_VALUE=203
    X_OR_Z_UNDERSCORE=204
    EDGE_DESCRIPTOR=205
    HEX_VALUE=206
    FILE_PATH_SPEC=207
    OCTAL_VALUE=208
    EDGE_SYMBOL=209
    LEVEL_ONLY_SYMBOL=210
    OUTPUT_OR_LEVEL_SYMBOL=211
    BEGIN_KEYWORDS_DIRECTIVE=212
    CELLDEFINE_DIRECTIVE=213
    DEFAULT_NETTYPE_DIRECTIVE=214
    DEFINE_DIRECTIVE=215
    ELSE_DIRECTIVE=216
    ELSIF_DIRECTIVE=217
    END_KEYWORDS_DIRECTIVE=218
    ENDCELLDEFINE_DIRECTIVE=219
    ENDIF_DIRECTIVE=220
    IFDEF_DIRECTIVE=221
    IFNDEF_DIRECTIVE=222
    INCLUDE_DIRECTIVE=223
    LINE_DIRECTIVE=224
    NOUNCONNECTED_DRIVE_DIRECTIVE=225
    PRAGMA_DIRECTIVE=226
    RESETALL_DIRECTIVE=227
    TIMESCALE_DIRECTIVE=228
    UNCONNECTED_DRIVE_DIRECTIVE=229
    UNDEF_DIRECTIVE=230
    MACRO_USAGE=231
    VERSION_SPECIFIER=232
    DEFAULT_NETTYPE_VALUE=233
    MACRO_NAME=234
    FILENAME=235
    MACRO_DELIMITER=236
    MACRO_ESC_NEWLINE=237
    MACRO_ESC_QUOTE=238
    MACRO_QUOTE=239
    MACRO_TEXT=240
    SOURCE_TEXT=241
    TIME_UNIT=242
    TIME_VALUE=243
    UNCONNECTED_DRIVE_VALUE=244
    MACRO_IDENTIFIER=245

    def __init__(self, input:TokenStream, output:TextIO = sys.stdout):
        super().__init__(input, output)
        self.checkVersion("4.7.2")
        self._interp = ParserATNSimulator(self, self.atn, self.decisionsToDFA, self.sharedContextCache)
        self._predicates = None



    class Source_textContext(ParserRuleContext):

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def compiler_directive(self, i:int=None):
            if i is None:
                return self.getTypedRuleContexts(VerilogPreParser.Compiler_directiveContext)
            else:
                return self.getTypedRuleContext(VerilogPreParser.Compiler_directiveContext,i)


        def getRuleIndex(self):
            return VerilogPreParser.RULE_source_text

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterSource_text" ):
                listener.enterSource_text(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitSource_text" ):
                listener.exitSource_text(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitSource_text" ):
                return visitor.visitSource_text(self)
            else:
                return visitor.visitChildren(self)




    def source_text(self):

        localctx = VerilogPreParser.Source_textContext(self, self._ctx, self.state)
        self.enterRule(localctx, 0, self.RULE_source_text)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 97
            self._errHandler.sync(self)
            _la = self._input.LA(1)
            while _la==VerilogPreParser.GA:
                self.state = 94
                self.compiler_directive()
                self.state = 99
                self._errHandler.sync(self)
                _la = self._input.LA(1)

        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class Compiler_directiveContext(ParserRuleContext):

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def begin_keywords_directive(self):
            return self.getTypedRuleContext(VerilogPreParser.Begin_keywords_directiveContext,0)


        def celldefine_directive(self):
            return self.getTypedRuleContext(VerilogPreParser.Celldefine_directiveContext,0)


        def default_nettype_directive(self):
            return self.getTypedRuleContext(VerilogPreParser.Default_nettype_directiveContext,0)


        def end_keywords_directive(self):
            return self.getTypedRuleContext(VerilogPreParser.End_keywords_directiveContext,0)


        def endcelldefine_directive(self):
            return self.getTypedRuleContext(VerilogPreParser.Endcelldefine_directiveContext,0)


        def ifdef_directive(self):
            return self.getTypedRuleContext(VerilogPreParser.Ifdef_directiveContext,0)


        def ifndef_directive(self):
            return self.getTypedRuleContext(VerilogPreParser.Ifndef_directiveContext,0)


        def include_directive(self):
            return self.getTypedRuleContext(VerilogPreParser.Include_directiveContext,0)


        def line_directive(self):
            return self.getTypedRuleContext(VerilogPreParser.Line_directiveContext,0)


        def nounconnected_drive_directive(self):
            return self.getTypedRuleContext(VerilogPreParser.Nounconnected_drive_directiveContext,0)


        def pragma_directive(self):
            return self.getTypedRuleContext(VerilogPreParser.Pragma_directiveContext,0)


        def resetall_directive(self):
            return self.getTypedRuleContext(VerilogPreParser.Resetall_directiveContext,0)


        def text_macro_definition(self):
            return self.getTypedRuleContext(VerilogPreParser.Text_macro_definitionContext,0)


        def text_macro_usage(self):
            return self.getTypedRuleContext(VerilogPreParser.Text_macro_usageContext,0)


        def timescale_directive(self):
            return self.getTypedRuleContext(VerilogPreParser.Timescale_directiveContext,0)


        def unconnected_drive_directive(self):
            return self.getTypedRuleContext(VerilogPreParser.Unconnected_drive_directiveContext,0)


        def undef_directive(self):
            return self.getTypedRuleContext(VerilogPreParser.Undef_directiveContext,0)


        def getRuleIndex(self):
            return VerilogPreParser.RULE_compiler_directive

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterCompiler_directive" ):
                listener.enterCompiler_directive(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitCompiler_directive" ):
                listener.exitCompiler_directive(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitCompiler_directive" ):
                return visitor.visitCompiler_directive(self)
            else:
                return visitor.visitChildren(self)




    def compiler_directive(self):

        localctx = VerilogPreParser.Compiler_directiveContext(self, self._ctx, self.state)
        self.enterRule(localctx, 2, self.RULE_compiler_directive)
        try:
            self.state = 117
            self._errHandler.sync(self)
            la_ = self._interp.adaptivePredict(self._input,1,self._ctx)
            if la_ == 1:
                self.enterOuterAlt(localctx, 1)
                self.state = 100
                self.begin_keywords_directive()
                pass

            elif la_ == 2:
                self.enterOuterAlt(localctx, 2)
                self.state = 101
                self.celldefine_directive()
                pass

            elif la_ == 3:
                self.enterOuterAlt(localctx, 3)
                self.state = 102
                self.default_nettype_directive()
                pass

            elif la_ == 4:
                self.enterOuterAlt(localctx, 4)
                self.state = 103
                self.end_keywords_directive()
                pass

            elif la_ == 5:
                self.enterOuterAlt(localctx, 5)
                self.state = 104
                self.endcelldefine_directive()
                pass

            elif la_ == 6:
                self.enterOuterAlt(localctx, 6)
                self.state = 105
                self.ifdef_directive()
                pass

            elif la_ == 7:
                self.enterOuterAlt(localctx, 7)
                self.state = 106
                self.ifndef_directive()
                pass

            elif la_ == 8:
                self.enterOuterAlt(localctx, 8)
                self.state = 107
                self.include_directive()
                pass

            elif la_ == 9:
                self.enterOuterAlt(localctx, 9)
                self.state = 108
                self.line_directive()
                pass

            elif la_ == 10:
                self.enterOuterAlt(localctx, 10)
                self.state = 109
                self.nounconnected_drive_directive()
                pass

            elif la_ == 11:
                self.enterOuterAlt(localctx, 11)
                self.state = 110
                self.pragma_directive()
                pass

            elif la_ == 12:
                self.enterOuterAlt(localctx, 12)
                self.state = 111
                self.resetall_directive()
                pass

            elif la_ == 13:
                self.enterOuterAlt(localctx, 13)
                self.state = 112
                self.text_macro_definition()
                pass

            elif la_ == 14:
                self.enterOuterAlt(localctx, 14)
                self.state = 113
                self.text_macro_usage()
                pass

            elif la_ == 15:
                self.enterOuterAlt(localctx, 15)
                self.state = 114
                self.timescale_directive()
                pass

            elif la_ == 16:
                self.enterOuterAlt(localctx, 16)
                self.state = 115
                self.unconnected_drive_directive()
                pass

            elif la_ == 17:
                self.enterOuterAlt(localctx, 17)
                self.state = 116
                self.undef_directive()
                pass


        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class Begin_keywords_directiveContext(ParserRuleContext):

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def GA(self):
            return self.getToken(VerilogPreParser.GA, 0)

        def BEGIN_KEYWORDS_DIRECTIVE(self):
            return self.getToken(VerilogPreParser.BEGIN_KEYWORDS_DIRECTIVE, 0)

        def DQ(self, i:int=None):
            if i is None:
                return self.getTokens(VerilogPreParser.DQ)
            else:
                return self.getToken(VerilogPreParser.DQ, i)

        def version_specifier(self):
            return self.getTypedRuleContext(VerilogPreParser.Version_specifierContext,0)


        def getRuleIndex(self):
            return VerilogPreParser.RULE_begin_keywords_directive

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterBegin_keywords_directive" ):
                listener.enterBegin_keywords_directive(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitBegin_keywords_directive" ):
                listener.exitBegin_keywords_directive(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitBegin_keywords_directive" ):
                return visitor.visitBegin_keywords_directive(self)
            else:
                return visitor.visitChildren(self)




    def begin_keywords_directive(self):

        localctx = VerilogPreParser.Begin_keywords_directiveContext(self, self._ctx, self.state)
        self.enterRule(localctx, 4, self.RULE_begin_keywords_directive)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 119
            self.match(VerilogPreParser.GA)
            self.state = 120
            self.match(VerilogPreParser.BEGIN_KEYWORDS_DIRECTIVE)
            self.state = 121
            self.match(VerilogPreParser.DQ)
            self.state = 122
            self.version_specifier()
            self.state = 123
            self.match(VerilogPreParser.DQ)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class Celldefine_directiveContext(ParserRuleContext):

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def GA(self):
            return self.getToken(VerilogPreParser.GA, 0)

        def CELLDEFINE_DIRECTIVE(self):
            return self.getToken(VerilogPreParser.CELLDEFINE_DIRECTIVE, 0)

        def getRuleIndex(self):
            return VerilogPreParser.RULE_celldefine_directive

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterCelldefine_directive" ):
                listener.enterCelldefine_directive(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitCelldefine_directive" ):
                listener.exitCelldefine_directive(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitCelldefine_directive" ):
                return visitor.visitCelldefine_directive(self)
            else:
                return visitor.visitChildren(self)




    def celldefine_directive(self):

        localctx = VerilogPreParser.Celldefine_directiveContext(self, self._ctx, self.state)
        self.enterRule(localctx, 6, self.RULE_celldefine_directive)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 125
            self.match(VerilogPreParser.GA)
            self.state = 126
            self.match(VerilogPreParser.CELLDEFINE_DIRECTIVE)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class Default_nettype_directiveContext(ParserRuleContext):

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def GA(self):
            return self.getToken(VerilogPreParser.GA, 0)

        def DEFAULT_NETTYPE_DIRECTIVE(self):
            return self.getToken(VerilogPreParser.DEFAULT_NETTYPE_DIRECTIVE, 0)

        def default_nettype_value(self):
            return self.getTypedRuleContext(VerilogPreParser.Default_nettype_valueContext,0)


        def getRuleIndex(self):
            return VerilogPreParser.RULE_default_nettype_directive

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterDefault_nettype_directive" ):
                listener.enterDefault_nettype_directive(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitDefault_nettype_directive" ):
                listener.exitDefault_nettype_directive(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitDefault_nettype_directive" ):
                return visitor.visitDefault_nettype_directive(self)
            else:
                return visitor.visitChildren(self)




    def default_nettype_directive(self):

        localctx = VerilogPreParser.Default_nettype_directiveContext(self, self._ctx, self.state)
        self.enterRule(localctx, 8, self.RULE_default_nettype_directive)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 128
            self.match(VerilogPreParser.GA)
            self.state = 129
            self.match(VerilogPreParser.DEFAULT_NETTYPE_DIRECTIVE)
            self.state = 130
            self.default_nettype_value()
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class Default_nettype_valueContext(ParserRuleContext):

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def DEFAULT_NETTYPE_VALUE(self):
            return self.getToken(VerilogPreParser.DEFAULT_NETTYPE_VALUE, 0)

        def getRuleIndex(self):
            return VerilogPreParser.RULE_default_nettype_value

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterDefault_nettype_value" ):
                listener.enterDefault_nettype_value(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitDefault_nettype_value" ):
                listener.exitDefault_nettype_value(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitDefault_nettype_value" ):
                return visitor.visitDefault_nettype_value(self)
            else:
                return visitor.visitChildren(self)




    def default_nettype_value(self):

        localctx = VerilogPreParser.Default_nettype_valueContext(self, self._ctx, self.state)
        self.enterRule(localctx, 10, self.RULE_default_nettype_value)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 132
            self.match(VerilogPreParser.DEFAULT_NETTYPE_VALUE)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class Else_directiveContext(ParserRuleContext):

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def GA(self):
            return self.getToken(VerilogPreParser.GA, 0)

        def ELSE_DIRECTIVE(self):
            return self.getToken(VerilogPreParser.ELSE_DIRECTIVE, 0)

        def group_of_lines(self):
            return self.getTypedRuleContext(VerilogPreParser.Group_of_linesContext,0)


        def getRuleIndex(self):
            return VerilogPreParser.RULE_else_directive

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterElse_directive" ):
                listener.enterElse_directive(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitElse_directive" ):
                listener.exitElse_directive(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitElse_directive" ):
                return visitor.visitElse_directive(self)
            else:
                return visitor.visitChildren(self)




    def else_directive(self):

        localctx = VerilogPreParser.Else_directiveContext(self, self._ctx, self.state)
        self.enterRule(localctx, 12, self.RULE_else_directive)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 134
            self.match(VerilogPreParser.GA)
            self.state = 135
            self.match(VerilogPreParser.ELSE_DIRECTIVE)
            self.state = 136
            self.group_of_lines()
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class Elsif_directiveContext(ParserRuleContext):

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def GA(self):
            return self.getToken(VerilogPreParser.GA, 0)

        def ELSIF_DIRECTIVE(self):
            return self.getToken(VerilogPreParser.ELSIF_DIRECTIVE, 0)

        def macro_identifier(self):
            return self.getTypedRuleContext(VerilogPreParser.Macro_identifierContext,0)


        def group_of_lines(self):
            return self.getTypedRuleContext(VerilogPreParser.Group_of_linesContext,0)


        def getRuleIndex(self):
            return VerilogPreParser.RULE_elsif_directive

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterElsif_directive" ):
                listener.enterElsif_directive(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitElsif_directive" ):
                listener.exitElsif_directive(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitElsif_directive" ):
                return visitor.visitElsif_directive(self)
            else:
                return visitor.visitChildren(self)




    def elsif_directive(self):

        localctx = VerilogPreParser.Elsif_directiveContext(self, self._ctx, self.state)
        self.enterRule(localctx, 14, self.RULE_elsif_directive)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 138
            self.match(VerilogPreParser.GA)
            self.state = 139
            self.match(VerilogPreParser.ELSIF_DIRECTIVE)
            self.state = 140
            self.macro_identifier()
            self.state = 141
            self.group_of_lines()
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class End_keywords_directiveContext(ParserRuleContext):

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def GA(self):
            return self.getToken(VerilogPreParser.GA, 0)

        def END_KEYWORDS_DIRECTIVE(self):
            return self.getToken(VerilogPreParser.END_KEYWORDS_DIRECTIVE, 0)

        def getRuleIndex(self):
            return VerilogPreParser.RULE_end_keywords_directive

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterEnd_keywords_directive" ):
                listener.enterEnd_keywords_directive(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitEnd_keywords_directive" ):
                listener.exitEnd_keywords_directive(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitEnd_keywords_directive" ):
                return visitor.visitEnd_keywords_directive(self)
            else:
                return visitor.visitChildren(self)




    def end_keywords_directive(self):

        localctx = VerilogPreParser.End_keywords_directiveContext(self, self._ctx, self.state)
        self.enterRule(localctx, 16, self.RULE_end_keywords_directive)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 143
            self.match(VerilogPreParser.GA)
            self.state = 144
            self.match(VerilogPreParser.END_KEYWORDS_DIRECTIVE)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class Endcelldefine_directiveContext(ParserRuleContext):

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def GA(self):
            return self.getToken(VerilogPreParser.GA, 0)

        def ENDCELLDEFINE_DIRECTIVE(self):
            return self.getToken(VerilogPreParser.ENDCELLDEFINE_DIRECTIVE, 0)

        def getRuleIndex(self):
            return VerilogPreParser.RULE_endcelldefine_directive

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterEndcelldefine_directive" ):
                listener.enterEndcelldefine_directive(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitEndcelldefine_directive" ):
                listener.exitEndcelldefine_directive(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitEndcelldefine_directive" ):
                return visitor.visitEndcelldefine_directive(self)
            else:
                return visitor.visitChildren(self)




    def endcelldefine_directive(self):

        localctx = VerilogPreParser.Endcelldefine_directiveContext(self, self._ctx, self.state)
        self.enterRule(localctx, 18, self.RULE_endcelldefine_directive)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 146
            self.match(VerilogPreParser.GA)
            self.state = 147
            self.match(VerilogPreParser.ENDCELLDEFINE_DIRECTIVE)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class Endif_directiveContext(ParserRuleContext):

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def GA(self):
            return self.getToken(VerilogPreParser.GA, 0)

        def ENDIF_DIRECTIVE(self):
            return self.getToken(VerilogPreParser.ENDIF_DIRECTIVE, 0)

        def getRuleIndex(self):
            return VerilogPreParser.RULE_endif_directive

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterEndif_directive" ):
                listener.enterEndif_directive(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitEndif_directive" ):
                listener.exitEndif_directive(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitEndif_directive" ):
                return visitor.visitEndif_directive(self)
            else:
                return visitor.visitChildren(self)




    def endif_directive(self):

        localctx = VerilogPreParser.Endif_directiveContext(self, self._ctx, self.state)
        self.enterRule(localctx, 20, self.RULE_endif_directive)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 149
            self.match(VerilogPreParser.GA)
            self.state = 150
            self.match(VerilogPreParser.ENDIF_DIRECTIVE)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class FilenameContext(ParserRuleContext):

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def FILENAME(self):
            return self.getToken(VerilogPreParser.FILENAME, 0)

        def getRuleIndex(self):
            return VerilogPreParser.RULE_filename

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterFilename" ):
                listener.enterFilename(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitFilename" ):
                listener.exitFilename(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitFilename" ):
                return visitor.visitFilename(self)
            else:
                return visitor.visitChildren(self)




    def filename(self):

        localctx = VerilogPreParser.FilenameContext(self, self._ctx, self.state)
        self.enterRule(localctx, 22, self.RULE_filename)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 152
            self.match(VerilogPreParser.FILENAME)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class Group_of_linesContext(ParserRuleContext):

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def source_text_(self, i:int=None):
            if i is None:
                return self.getTypedRuleContexts(VerilogPreParser.Source_text_Context)
            else:
                return self.getTypedRuleContext(VerilogPreParser.Source_text_Context,i)


        def compiler_directive(self, i:int=None):
            if i is None:
                return self.getTypedRuleContexts(VerilogPreParser.Compiler_directiveContext)
            else:
                return self.getTypedRuleContext(VerilogPreParser.Compiler_directiveContext,i)


        def getRuleIndex(self):
            return VerilogPreParser.RULE_group_of_lines

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterGroup_of_lines" ):
                listener.enterGroup_of_lines(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitGroup_of_lines" ):
                listener.exitGroup_of_lines(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitGroup_of_lines" ):
                return visitor.visitGroup_of_lines(self)
            else:
                return visitor.visitChildren(self)




    def group_of_lines(self):

        localctx = VerilogPreParser.Group_of_linesContext(self, self._ctx, self.state)
        self.enterRule(localctx, 24, self.RULE_group_of_lines)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 158
            self._errHandler.sync(self)
            _alt = self._interp.adaptivePredict(self._input,3,self._ctx)
            while _alt!=2 and _alt!=ATN.INVALID_ALT_NUMBER:
                if _alt==1:
                    self.state = 156
                    self._errHandler.sync(self)
                    token = self._input.LA(1)
                    if token in [VerilogPreParser.SOURCE_TEXT]:
                        self.state = 154
                        self.source_text_()
                        pass
                    elif token in [VerilogPreParser.GA]:
                        self.state = 155
                        self.compiler_directive()
                        pass
                    else:
                        raise NoViableAltException(self)
             
                self.state = 160
                self._errHandler.sync(self)
                _alt = self._interp.adaptivePredict(self._input,3,self._ctx)

        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class IdentifierContext(ParserRuleContext):

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def SIMPLE_IDENTIFIER(self):
            return self.getToken(VerilogPreParser.SIMPLE_IDENTIFIER, 0)

        def getRuleIndex(self):
            return VerilogPreParser.RULE_identifier

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterIdentifier" ):
                listener.enterIdentifier(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitIdentifier" ):
                listener.exitIdentifier(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitIdentifier" ):
                return visitor.visitIdentifier(self)
            else:
                return visitor.visitChildren(self)




    def identifier(self):

        localctx = VerilogPreParser.IdentifierContext(self, self._ctx, self.state)
        self.enterRule(localctx, 26, self.RULE_identifier)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 161
            self.match(VerilogPreParser.SIMPLE_IDENTIFIER)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class Ifdef_directiveContext(ParserRuleContext):

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def GA(self):
            return self.getToken(VerilogPreParser.GA, 0)

        def IFDEF_DIRECTIVE(self):
            return self.getToken(VerilogPreParser.IFDEF_DIRECTIVE, 0)

        def macro_identifier(self):
            return self.getTypedRuleContext(VerilogPreParser.Macro_identifierContext,0)


        def group_of_lines(self):
            return self.getTypedRuleContext(VerilogPreParser.Group_of_linesContext,0)


        def endif_directive(self):
            return self.getTypedRuleContext(VerilogPreParser.Endif_directiveContext,0)


        def elsif_directive(self, i:int=None):
            if i is None:
                return self.getTypedRuleContexts(VerilogPreParser.Elsif_directiveContext)
            else:
                return self.getTypedRuleContext(VerilogPreParser.Elsif_directiveContext,i)


        def else_directive(self):
            return self.getTypedRuleContext(VerilogPreParser.Else_directiveContext,0)


        def getRuleIndex(self):
            return VerilogPreParser.RULE_ifdef_directive

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterIfdef_directive" ):
                listener.enterIfdef_directive(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitIfdef_directive" ):
                listener.exitIfdef_directive(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitIfdef_directive" ):
                return visitor.visitIfdef_directive(self)
            else:
                return visitor.visitChildren(self)




    def ifdef_directive(self):

        localctx = VerilogPreParser.Ifdef_directiveContext(self, self._ctx, self.state)
        self.enterRule(localctx, 28, self.RULE_ifdef_directive)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 163
            self.match(VerilogPreParser.GA)
            self.state = 164
            self.match(VerilogPreParser.IFDEF_DIRECTIVE)
            self.state = 165
            self.macro_identifier()
            self.state = 166
            self.group_of_lines()
            self.state = 170
            self._errHandler.sync(self)
            _alt = self._interp.adaptivePredict(self._input,4,self._ctx)
            while _alt!=2 and _alt!=ATN.INVALID_ALT_NUMBER:
                if _alt==1:
                    self.state = 167
                    self.elsif_directive() 
                self.state = 172
                self._errHandler.sync(self)
                _alt = self._interp.adaptivePredict(self._input,4,self._ctx)

            self.state = 174
            self._errHandler.sync(self)
            la_ = self._interp.adaptivePredict(self._input,5,self._ctx)
            if la_ == 1:
                self.state = 173
                self.else_directive()


            self.state = 176
            self.endif_directive()
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class Ifndef_directiveContext(ParserRuleContext):

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def GA(self):
            return self.getToken(VerilogPreParser.GA, 0)

        def IFNDEF_DIRECTIVE(self):
            return self.getToken(VerilogPreParser.IFNDEF_DIRECTIVE, 0)

        def macro_identifier(self):
            return self.getTypedRuleContext(VerilogPreParser.Macro_identifierContext,0)


        def group_of_lines(self):
            return self.getTypedRuleContext(VerilogPreParser.Group_of_linesContext,0)


        def endif_directive(self):
            return self.getTypedRuleContext(VerilogPreParser.Endif_directiveContext,0)


        def elsif_directive(self, i:int=None):
            if i is None:
                return self.getTypedRuleContexts(VerilogPreParser.Elsif_directiveContext)
            else:
                return self.getTypedRuleContext(VerilogPreParser.Elsif_directiveContext,i)


        def else_directive(self):
            return self.getTypedRuleContext(VerilogPreParser.Else_directiveContext,0)


        def getRuleIndex(self):
            return VerilogPreParser.RULE_ifndef_directive

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterIfndef_directive" ):
                listener.enterIfndef_directive(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitIfndef_directive" ):
                listener.exitIfndef_directive(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitIfndef_directive" ):
                return visitor.visitIfndef_directive(self)
            else:
                return visitor.visitChildren(self)




    def ifndef_directive(self):

        localctx = VerilogPreParser.Ifndef_directiveContext(self, self._ctx, self.state)
        self.enterRule(localctx, 30, self.RULE_ifndef_directive)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 178
            self.match(VerilogPreParser.GA)
            self.state = 179
            self.match(VerilogPreParser.IFNDEF_DIRECTIVE)
            self.state = 180
            self.macro_identifier()
            self.state = 181
            self.group_of_lines()
            self.state = 185
            self._errHandler.sync(self)
            _alt = self._interp.adaptivePredict(self._input,6,self._ctx)
            while _alt!=2 and _alt!=ATN.INVALID_ALT_NUMBER:
                if _alt==1:
                    self.state = 182
                    self.elsif_directive() 
                self.state = 187
                self._errHandler.sync(self)
                _alt = self._interp.adaptivePredict(self._input,6,self._ctx)

            self.state = 189
            self._errHandler.sync(self)
            la_ = self._interp.adaptivePredict(self._input,7,self._ctx)
            if la_ == 1:
                self.state = 188
                self.else_directive()


            self.state = 191
            self.endif_directive()
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class Include_directiveContext(ParserRuleContext):

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def GA(self):
            return self.getToken(VerilogPreParser.GA, 0)

        def INCLUDE_DIRECTIVE(self):
            return self.getToken(VerilogPreParser.INCLUDE_DIRECTIVE, 0)

        def DQ(self, i:int=None):
            if i is None:
                return self.getTokens(VerilogPreParser.DQ)
            else:
                return self.getToken(VerilogPreParser.DQ, i)

        def filename(self):
            return self.getTypedRuleContext(VerilogPreParser.FilenameContext,0)


        def getRuleIndex(self):
            return VerilogPreParser.RULE_include_directive

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterInclude_directive" ):
                listener.enterInclude_directive(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitInclude_directive" ):
                listener.exitInclude_directive(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitInclude_directive" ):
                return visitor.visitInclude_directive(self)
            else:
                return visitor.visitChildren(self)




    def include_directive(self):

        localctx = VerilogPreParser.Include_directiveContext(self, self._ctx, self.state)
        self.enterRule(localctx, 32, self.RULE_include_directive)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 193
            self.match(VerilogPreParser.GA)
            self.state = 194
            self.match(VerilogPreParser.INCLUDE_DIRECTIVE)
            self.state = 195
            self.match(VerilogPreParser.DQ)
            self.state = 196
            self.filename()
            self.state = 197
            self.match(VerilogPreParser.DQ)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class LevelContext(ParserRuleContext):

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def UNSIGNED_NUMBER(self):
            return self.getToken(VerilogPreParser.UNSIGNED_NUMBER, 0)

        def getRuleIndex(self):
            return VerilogPreParser.RULE_level

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterLevel" ):
                listener.enterLevel(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitLevel" ):
                listener.exitLevel(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitLevel" ):
                return visitor.visitLevel(self)
            else:
                return visitor.visitChildren(self)




    def level(self):

        localctx = VerilogPreParser.LevelContext(self, self._ctx, self.state)
        self.enterRule(localctx, 34, self.RULE_level)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 199
            self.match(VerilogPreParser.UNSIGNED_NUMBER)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class Line_directiveContext(ParserRuleContext):

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def GA(self):
            return self.getToken(VerilogPreParser.GA, 0)

        def LINE_DIRECTIVE(self):
            return self.getToken(VerilogPreParser.LINE_DIRECTIVE, 0)

        def number(self):
            return self.getTypedRuleContext(VerilogPreParser.NumberContext,0)


        def DQ(self, i:int=None):
            if i is None:
                return self.getTokens(VerilogPreParser.DQ)
            else:
                return self.getToken(VerilogPreParser.DQ, i)

        def filename(self):
            return self.getTypedRuleContext(VerilogPreParser.FilenameContext,0)


        def level(self):
            return self.getTypedRuleContext(VerilogPreParser.LevelContext,0)


        def getRuleIndex(self):
            return VerilogPreParser.RULE_line_directive

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterLine_directive" ):
                listener.enterLine_directive(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitLine_directive" ):
                listener.exitLine_directive(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitLine_directive" ):
                return visitor.visitLine_directive(self)
            else:
                return visitor.visitChildren(self)




    def line_directive(self):

        localctx = VerilogPreParser.Line_directiveContext(self, self._ctx, self.state)
        self.enterRule(localctx, 36, self.RULE_line_directive)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 201
            self.match(VerilogPreParser.GA)
            self.state = 202
            self.match(VerilogPreParser.LINE_DIRECTIVE)
            self.state = 203
            self.number()
            self.state = 204
            self.match(VerilogPreParser.DQ)
            self.state = 205
            self.filename()
            self.state = 206
            self.match(VerilogPreParser.DQ)
            self.state = 207
            self.level()
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class Macro_delimiterContext(ParserRuleContext):

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def MACRO_DELIMITER(self):
            return self.getToken(VerilogPreParser.MACRO_DELIMITER, 0)

        def getRuleIndex(self):
            return VerilogPreParser.RULE_macro_delimiter

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterMacro_delimiter" ):
                listener.enterMacro_delimiter(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitMacro_delimiter" ):
                listener.exitMacro_delimiter(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitMacro_delimiter" ):
                return visitor.visitMacro_delimiter(self)
            else:
                return visitor.visitChildren(self)




    def macro_delimiter(self):

        localctx = VerilogPreParser.Macro_delimiterContext(self, self._ctx, self.state)
        self.enterRule(localctx, 38, self.RULE_macro_delimiter)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 209
            self.match(VerilogPreParser.MACRO_DELIMITER)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class Macro_esc_newlineContext(ParserRuleContext):

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def MACRO_ESC_NEWLINE(self):
            return self.getToken(VerilogPreParser.MACRO_ESC_NEWLINE, 0)

        def getRuleIndex(self):
            return VerilogPreParser.RULE_macro_esc_newline

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterMacro_esc_newline" ):
                listener.enterMacro_esc_newline(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitMacro_esc_newline" ):
                listener.exitMacro_esc_newline(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitMacro_esc_newline" ):
                return visitor.visitMacro_esc_newline(self)
            else:
                return visitor.visitChildren(self)




    def macro_esc_newline(self):

        localctx = VerilogPreParser.Macro_esc_newlineContext(self, self._ctx, self.state)
        self.enterRule(localctx, 40, self.RULE_macro_esc_newline)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 211
            self.match(VerilogPreParser.MACRO_ESC_NEWLINE)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class Macro_esc_quoteContext(ParserRuleContext):

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def MACRO_ESC_QUOTE(self):
            return self.getToken(VerilogPreParser.MACRO_ESC_QUOTE, 0)

        def getRuleIndex(self):
            return VerilogPreParser.RULE_macro_esc_quote

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterMacro_esc_quote" ):
                listener.enterMacro_esc_quote(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitMacro_esc_quote" ):
                listener.exitMacro_esc_quote(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitMacro_esc_quote" ):
                return visitor.visitMacro_esc_quote(self)
            else:
                return visitor.visitChildren(self)




    def macro_esc_quote(self):

        localctx = VerilogPreParser.Macro_esc_quoteContext(self, self._ctx, self.state)
        self.enterRule(localctx, 42, self.RULE_macro_esc_quote)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 213
            self.match(VerilogPreParser.MACRO_ESC_QUOTE)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class Macro_identifierContext(ParserRuleContext):

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def MACRO_IDENTIFIER(self):
            return self.getToken(VerilogPreParser.MACRO_IDENTIFIER, 0)

        def getRuleIndex(self):
            return VerilogPreParser.RULE_macro_identifier

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterMacro_identifier" ):
                listener.enterMacro_identifier(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitMacro_identifier" ):
                listener.exitMacro_identifier(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitMacro_identifier" ):
                return visitor.visitMacro_identifier(self)
            else:
                return visitor.visitChildren(self)




    def macro_identifier(self):

        localctx = VerilogPreParser.Macro_identifierContext(self, self._ctx, self.state)
        self.enterRule(localctx, 44, self.RULE_macro_identifier)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 215
            self.match(VerilogPreParser.MACRO_IDENTIFIER)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class Macro_nameContext(ParserRuleContext):

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def MACRO_NAME(self):
            return self.getToken(VerilogPreParser.MACRO_NAME, 0)

        def getRuleIndex(self):
            return VerilogPreParser.RULE_macro_name

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterMacro_name" ):
                listener.enterMacro_name(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitMacro_name" ):
                listener.exitMacro_name(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitMacro_name" ):
                return visitor.visitMacro_name(self)
            else:
                return visitor.visitChildren(self)




    def macro_name(self):

        localctx = VerilogPreParser.Macro_nameContext(self, self._ctx, self.state)
        self.enterRule(localctx, 46, self.RULE_macro_name)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 217
            self.match(VerilogPreParser.MACRO_NAME)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class Macro_quoteContext(ParserRuleContext):

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def MACRO_QUOTE(self):
            return self.getToken(VerilogPreParser.MACRO_QUOTE, 0)

        def getRuleIndex(self):
            return VerilogPreParser.RULE_macro_quote

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterMacro_quote" ):
                listener.enterMacro_quote(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitMacro_quote" ):
                listener.exitMacro_quote(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitMacro_quote" ):
                return visitor.visitMacro_quote(self)
            else:
                return visitor.visitChildren(self)




    def macro_quote(self):

        localctx = VerilogPreParser.Macro_quoteContext(self, self._ctx, self.state)
        self.enterRule(localctx, 48, self.RULE_macro_quote)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 219
            self.match(VerilogPreParser.MACRO_QUOTE)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class Macro_textContext(ParserRuleContext):

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def macro_text_(self, i:int=None):
            if i is None:
                return self.getTypedRuleContexts(VerilogPreParser.Macro_text_Context)
            else:
                return self.getTypedRuleContext(VerilogPreParser.Macro_text_Context,i)


        def macro_delimiter(self, i:int=None):
            if i is None:
                return self.getTypedRuleContexts(VerilogPreParser.Macro_delimiterContext)
            else:
                return self.getTypedRuleContext(VerilogPreParser.Macro_delimiterContext,i)


        def macro_esc_newline(self, i:int=None):
            if i is None:
                return self.getTypedRuleContexts(VerilogPreParser.Macro_esc_newlineContext)
            else:
                return self.getTypedRuleContext(VerilogPreParser.Macro_esc_newlineContext,i)


        def macro_esc_quote(self, i:int=None):
            if i is None:
                return self.getTypedRuleContexts(VerilogPreParser.Macro_esc_quoteContext)
            else:
                return self.getTypedRuleContext(VerilogPreParser.Macro_esc_quoteContext,i)


        def macro_quote(self, i:int=None):
            if i is None:
                return self.getTypedRuleContexts(VerilogPreParser.Macro_quoteContext)
            else:
                return self.getTypedRuleContext(VerilogPreParser.Macro_quoteContext,i)


        def string_(self, i:int=None):
            if i is None:
                return self.getTypedRuleContexts(VerilogPreParser.String_Context)
            else:
                return self.getTypedRuleContext(VerilogPreParser.String_Context,i)


        def getRuleIndex(self):
            return VerilogPreParser.RULE_macro_text

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterMacro_text" ):
                listener.enterMacro_text(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitMacro_text" ):
                listener.exitMacro_text(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitMacro_text" ):
                return visitor.visitMacro_text(self)
            else:
                return visitor.visitChildren(self)




    def macro_text(self):

        localctx = VerilogPreParser.Macro_textContext(self, self._ctx, self.state)
        self.enterRule(localctx, 50, self.RULE_macro_text)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 229
            self._errHandler.sync(self)
            _la = self._input.LA(1)
            while ((((_la - 199)) & ~0x3f) == 0 and ((1 << (_la - 199)) & ((1 << (VerilogPreParser.STRING - 199)) | (1 << (VerilogPreParser.MACRO_DELIMITER - 199)) | (1 << (VerilogPreParser.MACRO_ESC_NEWLINE - 199)) | (1 << (VerilogPreParser.MACRO_ESC_QUOTE - 199)) | (1 << (VerilogPreParser.MACRO_QUOTE - 199)) | (1 << (VerilogPreParser.MACRO_TEXT - 199)))) != 0):
                self.state = 227
                self._errHandler.sync(self)
                token = self._input.LA(1)
                if token in [VerilogPreParser.MACRO_TEXT]:
                    self.state = 221
                    self.macro_text_()
                    pass
                elif token in [VerilogPreParser.MACRO_DELIMITER]:
                    self.state = 222
                    self.macro_delimiter()
                    pass
                elif token in [VerilogPreParser.MACRO_ESC_NEWLINE]:
                    self.state = 223
                    self.macro_esc_newline()
                    pass
                elif token in [VerilogPreParser.MACRO_ESC_QUOTE]:
                    self.state = 224
                    self.macro_esc_quote()
                    pass
                elif token in [VerilogPreParser.MACRO_QUOTE]:
                    self.state = 225
                    self.macro_quote()
                    pass
                elif token in [VerilogPreParser.STRING]:
                    self.state = 226
                    self.string_()
                    pass
                else:
                    raise NoViableAltException(self)

                self.state = 231
                self._errHandler.sync(self)
                _la = self._input.LA(1)

        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class Macro_text_Context(ParserRuleContext):

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def MACRO_TEXT(self):
            return self.getToken(VerilogPreParser.MACRO_TEXT, 0)

        def getRuleIndex(self):
            return VerilogPreParser.RULE_macro_text_

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterMacro_text_" ):
                listener.enterMacro_text_(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitMacro_text_" ):
                listener.exitMacro_text_(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitMacro_text_" ):
                return visitor.visitMacro_text_(self)
            else:
                return visitor.visitChildren(self)




    def macro_text_(self):

        localctx = VerilogPreParser.Macro_text_Context(self, self._ctx, self.state)
        self.enterRule(localctx, 52, self.RULE_macro_text_)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 232
            self.match(VerilogPreParser.MACRO_TEXT)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class Macro_usageContext(ParserRuleContext):

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def MACRO_USAGE(self):
            return self.getToken(VerilogPreParser.MACRO_USAGE, 0)

        def getRuleIndex(self):
            return VerilogPreParser.RULE_macro_usage

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterMacro_usage" ):
                listener.enterMacro_usage(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitMacro_usage" ):
                listener.exitMacro_usage(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitMacro_usage" ):
                return visitor.visitMacro_usage(self)
            else:
                return visitor.visitChildren(self)




    def macro_usage(self):

        localctx = VerilogPreParser.Macro_usageContext(self, self._ctx, self.state)
        self.enterRule(localctx, 54, self.RULE_macro_usage)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 234
            self.match(VerilogPreParser.MACRO_USAGE)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class Nounconnected_drive_directiveContext(ParserRuleContext):

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def GA(self):
            return self.getToken(VerilogPreParser.GA, 0)

        def NOUNCONNECTED_DRIVE_DIRECTIVE(self):
            return self.getToken(VerilogPreParser.NOUNCONNECTED_DRIVE_DIRECTIVE, 0)

        def getRuleIndex(self):
            return VerilogPreParser.RULE_nounconnected_drive_directive

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterNounconnected_drive_directive" ):
                listener.enterNounconnected_drive_directive(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitNounconnected_drive_directive" ):
                listener.exitNounconnected_drive_directive(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitNounconnected_drive_directive" ):
                return visitor.visitNounconnected_drive_directive(self)
            else:
                return visitor.visitChildren(self)




    def nounconnected_drive_directive(self):

        localctx = VerilogPreParser.Nounconnected_drive_directiveContext(self, self._ctx, self.state)
        self.enterRule(localctx, 56, self.RULE_nounconnected_drive_directive)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 236
            self.match(VerilogPreParser.GA)
            self.state = 237
            self.match(VerilogPreParser.NOUNCONNECTED_DRIVE_DIRECTIVE)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class NumberContext(ParserRuleContext):

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def UNSIGNED_NUMBER(self):
            return self.getToken(VerilogPreParser.UNSIGNED_NUMBER, 0)

        def getRuleIndex(self):
            return VerilogPreParser.RULE_number

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterNumber" ):
                listener.enterNumber(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitNumber" ):
                listener.exitNumber(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitNumber" ):
                return visitor.visitNumber(self)
            else:
                return visitor.visitChildren(self)




    def number(self):

        localctx = VerilogPreParser.NumberContext(self, self._ctx, self.state)
        self.enterRule(localctx, 58, self.RULE_number)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 239
            self.match(VerilogPreParser.UNSIGNED_NUMBER)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class Pragma_directiveContext(ParserRuleContext):

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def GA(self):
            return self.getToken(VerilogPreParser.GA, 0)

        def PRAGMA_DIRECTIVE(self):
            return self.getToken(VerilogPreParser.PRAGMA_DIRECTIVE, 0)

        def pragma_name(self):
            return self.getTypedRuleContext(VerilogPreParser.Pragma_nameContext,0)


        def pragma_expression(self, i:int=None):
            if i is None:
                return self.getTypedRuleContexts(VerilogPreParser.Pragma_expressionContext)
            else:
                return self.getTypedRuleContext(VerilogPreParser.Pragma_expressionContext,i)


        def CO(self, i:int=None):
            if i is None:
                return self.getTokens(VerilogPreParser.CO)
            else:
                return self.getToken(VerilogPreParser.CO, i)

        def getRuleIndex(self):
            return VerilogPreParser.RULE_pragma_directive

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterPragma_directive" ):
                listener.enterPragma_directive(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitPragma_directive" ):
                listener.exitPragma_directive(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitPragma_directive" ):
                return visitor.visitPragma_directive(self)
            else:
                return visitor.visitChildren(self)




    def pragma_directive(self):

        localctx = VerilogPreParser.Pragma_directiveContext(self, self._ctx, self.state)
        self.enterRule(localctx, 60, self.RULE_pragma_directive)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 241
            self.match(VerilogPreParser.GA)
            self.state = 242
            self.match(VerilogPreParser.PRAGMA_DIRECTIVE)
            self.state = 243
            self.pragma_name()
            self.state = 252
            self._errHandler.sync(self)
            _la = self._input.LA(1)
            if ((((_la - 166)) & ~0x3f) == 0 and ((1 << (_la - 166)) & ((1 << (VerilogPreParser.LP - 166)) | (1 << (VerilogPreParser.SIMPLE_IDENTIFIER - 166)) | (1 << (VerilogPreParser.STRING - 166)) | (1 << (VerilogPreParser.UNSIGNED_NUMBER - 166)))) != 0):
                self.state = 244
                self.pragma_expression()
                self.state = 249
                self._errHandler.sync(self)
                _la = self._input.LA(1)
                while _la==VerilogPreParser.CO:
                    self.state = 245
                    self.match(VerilogPreParser.CO)
                    self.state = 246
                    self.pragma_expression()
                    self.state = 251
                    self._errHandler.sync(self)
                    _la = self._input.LA(1)



        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class Pragma_expressionContext(ParserRuleContext):

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def pragma_value(self):
            return self.getTypedRuleContext(VerilogPreParser.Pragma_valueContext,0)


        def pragma_keyword(self):
            return self.getTypedRuleContext(VerilogPreParser.Pragma_keywordContext,0)


        def EQ(self):
            return self.getToken(VerilogPreParser.EQ, 0)

        def getRuleIndex(self):
            return VerilogPreParser.RULE_pragma_expression

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterPragma_expression" ):
                listener.enterPragma_expression(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitPragma_expression" ):
                listener.exitPragma_expression(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitPragma_expression" ):
                return visitor.visitPragma_expression(self)
            else:
                return visitor.visitChildren(self)




    def pragma_expression(self):

        localctx = VerilogPreParser.Pragma_expressionContext(self, self._ctx, self.state)
        self.enterRule(localctx, 62, self.RULE_pragma_expression)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 257
            self._errHandler.sync(self)
            la_ = self._interp.adaptivePredict(self._input,12,self._ctx)
            if la_ == 1:
                self.state = 254
                self.pragma_keyword()
                self.state = 255
                self.match(VerilogPreParser.EQ)


            self.state = 259
            self.pragma_value()
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class Pragma_keywordContext(ParserRuleContext):

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def SIMPLE_IDENTIFIER(self):
            return self.getToken(VerilogPreParser.SIMPLE_IDENTIFIER, 0)

        def getRuleIndex(self):
            return VerilogPreParser.RULE_pragma_keyword

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterPragma_keyword" ):
                listener.enterPragma_keyword(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitPragma_keyword" ):
                listener.exitPragma_keyword(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitPragma_keyword" ):
                return visitor.visitPragma_keyword(self)
            else:
                return visitor.visitChildren(self)




    def pragma_keyword(self):

        localctx = VerilogPreParser.Pragma_keywordContext(self, self._ctx, self.state)
        self.enterRule(localctx, 64, self.RULE_pragma_keyword)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 261
            self.match(VerilogPreParser.SIMPLE_IDENTIFIER)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class Pragma_nameContext(ParserRuleContext):

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def SIMPLE_IDENTIFIER(self):
            return self.getToken(VerilogPreParser.SIMPLE_IDENTIFIER, 0)

        def getRuleIndex(self):
            return VerilogPreParser.RULE_pragma_name

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterPragma_name" ):
                listener.enterPragma_name(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitPragma_name" ):
                listener.exitPragma_name(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitPragma_name" ):
                return visitor.visitPragma_name(self)
            else:
                return visitor.visitChildren(self)




    def pragma_name(self):

        localctx = VerilogPreParser.Pragma_nameContext(self, self._ctx, self.state)
        self.enterRule(localctx, 66, self.RULE_pragma_name)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 263
            self.match(VerilogPreParser.SIMPLE_IDENTIFIER)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class Pragma_valueContext(ParserRuleContext):

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def LP(self):
            return self.getToken(VerilogPreParser.LP, 0)

        def pragma_expression(self, i:int=None):
            if i is None:
                return self.getTypedRuleContexts(VerilogPreParser.Pragma_expressionContext)
            else:
                return self.getTypedRuleContext(VerilogPreParser.Pragma_expressionContext,i)


        def RP(self):
            return self.getToken(VerilogPreParser.RP, 0)

        def CO(self, i:int=None):
            if i is None:
                return self.getTokens(VerilogPreParser.CO)
            else:
                return self.getToken(VerilogPreParser.CO, i)

        def number(self):
            return self.getTypedRuleContext(VerilogPreParser.NumberContext,0)


        def string_(self):
            return self.getTypedRuleContext(VerilogPreParser.String_Context,0)


        def identifier(self):
            return self.getTypedRuleContext(VerilogPreParser.IdentifierContext,0)


        def getRuleIndex(self):
            return VerilogPreParser.RULE_pragma_value

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterPragma_value" ):
                listener.enterPragma_value(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitPragma_value" ):
                listener.exitPragma_value(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitPragma_value" ):
                return visitor.visitPragma_value(self)
            else:
                return visitor.visitChildren(self)




    def pragma_value(self):

        localctx = VerilogPreParser.Pragma_valueContext(self, self._ctx, self.state)
        self.enterRule(localctx, 68, self.RULE_pragma_value)
        self._la = 0 # Token type
        try:
            self.state = 279
            self._errHandler.sync(self)
            token = self._input.LA(1)
            if token in [VerilogPreParser.LP]:
                self.enterOuterAlt(localctx, 1)
                self.state = 265
                self.match(VerilogPreParser.LP)
                self.state = 266
                self.pragma_expression()
                self.state = 271
                self._errHandler.sync(self)
                _la = self._input.LA(1)
                while _la==VerilogPreParser.CO:
                    self.state = 267
                    self.match(VerilogPreParser.CO)
                    self.state = 268
                    self.pragma_expression()
                    self.state = 273
                    self._errHandler.sync(self)
                    _la = self._input.LA(1)

                self.state = 274
                self.match(VerilogPreParser.RP)
                pass
            elif token in [VerilogPreParser.UNSIGNED_NUMBER]:
                self.enterOuterAlt(localctx, 2)
                self.state = 276
                self.number()
                pass
            elif token in [VerilogPreParser.STRING]:
                self.enterOuterAlt(localctx, 3)
                self.state = 277
                self.string_()
                pass
            elif token in [VerilogPreParser.SIMPLE_IDENTIFIER]:
                self.enterOuterAlt(localctx, 4)
                self.state = 278
                self.identifier()
                pass
            else:
                raise NoViableAltException(self)

        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class Resetall_directiveContext(ParserRuleContext):

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def GA(self):
            return self.getToken(VerilogPreParser.GA, 0)

        def RESETALL_DIRECTIVE(self):
            return self.getToken(VerilogPreParser.RESETALL_DIRECTIVE, 0)

        def getRuleIndex(self):
            return VerilogPreParser.RULE_resetall_directive

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterResetall_directive" ):
                listener.enterResetall_directive(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitResetall_directive" ):
                listener.exitResetall_directive(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitResetall_directive" ):
                return visitor.visitResetall_directive(self)
            else:
                return visitor.visitChildren(self)




    def resetall_directive(self):

        localctx = VerilogPreParser.Resetall_directiveContext(self, self._ctx, self.state)
        self.enterRule(localctx, 70, self.RULE_resetall_directive)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 281
            self.match(VerilogPreParser.GA)
            self.state = 282
            self.match(VerilogPreParser.RESETALL_DIRECTIVE)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class Source_text_Context(ParserRuleContext):

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def SOURCE_TEXT(self):
            return self.getToken(VerilogPreParser.SOURCE_TEXT, 0)

        def getRuleIndex(self):
            return VerilogPreParser.RULE_source_text_

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterSource_text_" ):
                listener.enterSource_text_(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitSource_text_" ):
                listener.exitSource_text_(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitSource_text_" ):
                return visitor.visitSource_text_(self)
            else:
                return visitor.visitChildren(self)




    def source_text_(self):

        localctx = VerilogPreParser.Source_text_Context(self, self._ctx, self.state)
        self.enterRule(localctx, 72, self.RULE_source_text_)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 284
            self.match(VerilogPreParser.SOURCE_TEXT)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class String_Context(ParserRuleContext):

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def STRING(self):
            return self.getToken(VerilogPreParser.STRING, 0)

        def getRuleIndex(self):
            return VerilogPreParser.RULE_string_

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterString_" ):
                listener.enterString_(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitString_" ):
                listener.exitString_(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitString_" ):
                return visitor.visitString_(self)
            else:
                return visitor.visitChildren(self)




    def string_(self):

        localctx = VerilogPreParser.String_Context(self, self._ctx, self.state)
        self.enterRule(localctx, 74, self.RULE_string_)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 286
            self.match(VerilogPreParser.STRING)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class Text_macro_definitionContext(ParserRuleContext):

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def GA(self):
            return self.getToken(VerilogPreParser.GA, 0)

        def DEFINE_DIRECTIVE(self):
            return self.getToken(VerilogPreParser.DEFINE_DIRECTIVE, 0)

        def macro_name(self):
            return self.getTypedRuleContext(VerilogPreParser.Macro_nameContext,0)


        def macro_text(self):
            return self.getTypedRuleContext(VerilogPreParser.Macro_textContext,0)


        def getRuleIndex(self):
            return VerilogPreParser.RULE_text_macro_definition

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterText_macro_definition" ):
                listener.enterText_macro_definition(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitText_macro_definition" ):
                listener.exitText_macro_definition(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitText_macro_definition" ):
                return visitor.visitText_macro_definition(self)
            else:
                return visitor.visitChildren(self)




    def text_macro_definition(self):

        localctx = VerilogPreParser.Text_macro_definitionContext(self, self._ctx, self.state)
        self.enterRule(localctx, 76, self.RULE_text_macro_definition)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 288
            self.match(VerilogPreParser.GA)
            self.state = 289
            self.match(VerilogPreParser.DEFINE_DIRECTIVE)
            self.state = 290
            self.macro_name()
            self.state = 291
            self.macro_text()
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class Text_macro_usageContext(ParserRuleContext):

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def GA(self):
            return self.getToken(VerilogPreParser.GA, 0)

        def macro_usage(self):
            return self.getTypedRuleContext(VerilogPreParser.Macro_usageContext,0)


        def getRuleIndex(self):
            return VerilogPreParser.RULE_text_macro_usage

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterText_macro_usage" ):
                listener.enterText_macro_usage(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitText_macro_usage" ):
                listener.exitText_macro_usage(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitText_macro_usage" ):
                return visitor.visitText_macro_usage(self)
            else:
                return visitor.visitChildren(self)




    def text_macro_usage(self):

        localctx = VerilogPreParser.Text_macro_usageContext(self, self._ctx, self.state)
        self.enterRule(localctx, 78, self.RULE_text_macro_usage)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 293
            self.match(VerilogPreParser.GA)
            self.state = 294
            self.macro_usage()
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class Time_precisionContext(ParserRuleContext):

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def TIME_VALUE(self):
            return self.getToken(VerilogPreParser.TIME_VALUE, 0)

        def TIME_UNIT(self):
            return self.getToken(VerilogPreParser.TIME_UNIT, 0)

        def getRuleIndex(self):
            return VerilogPreParser.RULE_time_precision

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterTime_precision" ):
                listener.enterTime_precision(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitTime_precision" ):
                listener.exitTime_precision(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitTime_precision" ):
                return visitor.visitTime_precision(self)
            else:
                return visitor.visitChildren(self)




    def time_precision(self):

        localctx = VerilogPreParser.Time_precisionContext(self, self._ctx, self.state)
        self.enterRule(localctx, 80, self.RULE_time_precision)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 296
            self.match(VerilogPreParser.TIME_VALUE)
            self.state = 297
            self.match(VerilogPreParser.TIME_UNIT)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class Time_unitContext(ParserRuleContext):

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def TIME_VALUE(self):
            return self.getToken(VerilogPreParser.TIME_VALUE, 0)

        def TIME_UNIT(self):
            return self.getToken(VerilogPreParser.TIME_UNIT, 0)

        def getRuleIndex(self):
            return VerilogPreParser.RULE_time_unit

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterTime_unit" ):
                listener.enterTime_unit(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitTime_unit" ):
                listener.exitTime_unit(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitTime_unit" ):
                return visitor.visitTime_unit(self)
            else:
                return visitor.visitChildren(self)




    def time_unit(self):

        localctx = VerilogPreParser.Time_unitContext(self, self._ctx, self.state)
        self.enterRule(localctx, 82, self.RULE_time_unit)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 299
            self.match(VerilogPreParser.TIME_VALUE)
            self.state = 300
            self.match(VerilogPreParser.TIME_UNIT)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class Timescale_directiveContext(ParserRuleContext):

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def GA(self):
            return self.getToken(VerilogPreParser.GA, 0)

        def TIMESCALE_DIRECTIVE(self):
            return self.getToken(VerilogPreParser.TIMESCALE_DIRECTIVE, 0)

        def time_unit(self):
            return self.getTypedRuleContext(VerilogPreParser.Time_unitContext,0)


        def SL(self):
            return self.getToken(VerilogPreParser.SL, 0)

        def time_precision(self):
            return self.getTypedRuleContext(VerilogPreParser.Time_precisionContext,0)


        def getRuleIndex(self):
            return VerilogPreParser.RULE_timescale_directive

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterTimescale_directive" ):
                listener.enterTimescale_directive(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitTimescale_directive" ):
                listener.exitTimescale_directive(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitTimescale_directive" ):
                return visitor.visitTimescale_directive(self)
            else:
                return visitor.visitChildren(self)




    def timescale_directive(self):

        localctx = VerilogPreParser.Timescale_directiveContext(self, self._ctx, self.state)
        self.enterRule(localctx, 84, self.RULE_timescale_directive)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 302
            self.match(VerilogPreParser.GA)
            self.state = 303
            self.match(VerilogPreParser.TIMESCALE_DIRECTIVE)
            self.state = 304
            self.time_unit()
            self.state = 305
            self.match(VerilogPreParser.SL)
            self.state = 306
            self.time_precision()
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class Unconnected_drive_directiveContext(ParserRuleContext):

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def GA(self):
            return self.getToken(VerilogPreParser.GA, 0)

        def UNCONNECTED_DRIVE_DIRECTIVE(self):
            return self.getToken(VerilogPreParser.UNCONNECTED_DRIVE_DIRECTIVE, 0)

        def unconnected_drive_value(self):
            return self.getTypedRuleContext(VerilogPreParser.Unconnected_drive_valueContext,0)


        def getRuleIndex(self):
            return VerilogPreParser.RULE_unconnected_drive_directive

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterUnconnected_drive_directive" ):
                listener.enterUnconnected_drive_directive(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitUnconnected_drive_directive" ):
                listener.exitUnconnected_drive_directive(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitUnconnected_drive_directive" ):
                return visitor.visitUnconnected_drive_directive(self)
            else:
                return visitor.visitChildren(self)




    def unconnected_drive_directive(self):

        localctx = VerilogPreParser.Unconnected_drive_directiveContext(self, self._ctx, self.state)
        self.enterRule(localctx, 86, self.RULE_unconnected_drive_directive)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 308
            self.match(VerilogPreParser.GA)
            self.state = 309
            self.match(VerilogPreParser.UNCONNECTED_DRIVE_DIRECTIVE)
            self.state = 310
            self.unconnected_drive_value()
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class Unconnected_drive_valueContext(ParserRuleContext):

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def UNCONNECTED_DRIVE_VALUE(self):
            return self.getToken(VerilogPreParser.UNCONNECTED_DRIVE_VALUE, 0)

        def getRuleIndex(self):
            return VerilogPreParser.RULE_unconnected_drive_value

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterUnconnected_drive_value" ):
                listener.enterUnconnected_drive_value(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitUnconnected_drive_value" ):
                listener.exitUnconnected_drive_value(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitUnconnected_drive_value" ):
                return visitor.visitUnconnected_drive_value(self)
            else:
                return visitor.visitChildren(self)




    def unconnected_drive_value(self):

        localctx = VerilogPreParser.Unconnected_drive_valueContext(self, self._ctx, self.state)
        self.enterRule(localctx, 88, self.RULE_unconnected_drive_value)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 312
            self.match(VerilogPreParser.UNCONNECTED_DRIVE_VALUE)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class Undef_directiveContext(ParserRuleContext):

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def GA(self):
            return self.getToken(VerilogPreParser.GA, 0)

        def UNDEF_DIRECTIVE(self):
            return self.getToken(VerilogPreParser.UNDEF_DIRECTIVE, 0)

        def macro_identifier(self):
            return self.getTypedRuleContext(VerilogPreParser.Macro_identifierContext,0)


        def getRuleIndex(self):
            return VerilogPreParser.RULE_undef_directive

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterUndef_directive" ):
                listener.enterUndef_directive(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitUndef_directive" ):
                listener.exitUndef_directive(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitUndef_directive" ):
                return visitor.visitUndef_directive(self)
            else:
                return visitor.visitChildren(self)




    def undef_directive(self):

        localctx = VerilogPreParser.Undef_directiveContext(self, self._ctx, self.state)
        self.enterRule(localctx, 90, self.RULE_undef_directive)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 314
            self.match(VerilogPreParser.GA)
            self.state = 315
            self.match(VerilogPreParser.UNDEF_DIRECTIVE)
            self.state = 316
            self.macro_identifier()
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class Version_specifierContext(ParserRuleContext):

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def VERSION_SPECIFIER(self):
            return self.getToken(VerilogPreParser.VERSION_SPECIFIER, 0)

        def getRuleIndex(self):
            return VerilogPreParser.RULE_version_specifier

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterVersion_specifier" ):
                listener.enterVersion_specifier(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitVersion_specifier" ):
                listener.exitVersion_specifier(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitVersion_specifier" ):
                return visitor.visitVersion_specifier(self)
            else:
                return visitor.visitChildren(self)




    def version_specifier(self):

        localctx = VerilogPreParser.Version_specifierContext(self, self._ctx, self.state)
        self.enterRule(localctx, 92, self.RULE_version_specifier)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 318
            self.match(VerilogPreParser.VERSION_SPECIFIER)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx





