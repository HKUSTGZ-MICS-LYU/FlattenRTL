# Generated from SystemVerilogPreParser.g4 by ANTLR 4.13.1
from antlr4 import *
if "." in __name__:
    from .SystemVerilogPreParser import SystemVerilogPreParser
else:
    from SystemVerilogPreParser import SystemVerilogPreParser

# This class defines a complete generic visitor for a parse tree produced by SystemVerilogPreParser.

class SystemVerilogPreParserVisitor(ParseTreeVisitor):

    # Visit a parse tree produced by SystemVerilogPreParser#source_text.
    def visitSource_text(self, ctx:SystemVerilogPreParser.Source_textContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SystemVerilogPreParser#compiler_directive.
    def visitCompiler_directive(self, ctx:SystemVerilogPreParser.Compiler_directiveContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SystemVerilogPreParser#begin_keywords_directive.
    def visitBegin_keywords_directive(self, ctx:SystemVerilogPreParser.Begin_keywords_directiveContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SystemVerilogPreParser#celldefine_directive.
    def visitCelldefine_directive(self, ctx:SystemVerilogPreParser.Celldefine_directiveContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SystemVerilogPreParser#default_nettype_directive.
    def visitDefault_nettype_directive(self, ctx:SystemVerilogPreParser.Default_nettype_directiveContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SystemVerilogPreParser#default_nettype_value.
    def visitDefault_nettype_value(self, ctx:SystemVerilogPreParser.Default_nettype_valueContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SystemVerilogPreParser#else_directive.
    def visitElse_directive(self, ctx:SystemVerilogPreParser.Else_directiveContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SystemVerilogPreParser#elsif_directive.
    def visitElsif_directive(self, ctx:SystemVerilogPreParser.Elsif_directiveContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SystemVerilogPreParser#end_keywords_directive.
    def visitEnd_keywords_directive(self, ctx:SystemVerilogPreParser.End_keywords_directiveContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SystemVerilogPreParser#endcelldefine_directive.
    def visitEndcelldefine_directive(self, ctx:SystemVerilogPreParser.Endcelldefine_directiveContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SystemVerilogPreParser#endif_directive.
    def visitEndif_directive(self, ctx:SystemVerilogPreParser.Endif_directiveContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SystemVerilogPreParser#file_directive.
    def visitFile_directive(self, ctx:SystemVerilogPreParser.File_directiveContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SystemVerilogPreParser#filename.
    def visitFilename(self, ctx:SystemVerilogPreParser.FilenameContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SystemVerilogPreParser#group_of_lines.
    def visitGroup_of_lines(self, ctx:SystemVerilogPreParser.Group_of_linesContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SystemVerilogPreParser#identifier.
    def visitIdentifier(self, ctx:SystemVerilogPreParser.IdentifierContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SystemVerilogPreParser#ifdef_directive.
    def visitIfdef_directive(self, ctx:SystemVerilogPreParser.Ifdef_directiveContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SystemVerilogPreParser#ifndef_directive.
    def visitIfndef_directive(self, ctx:SystemVerilogPreParser.Ifndef_directiveContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SystemVerilogPreParser#include_directive.
    def visitInclude_directive(self, ctx:SystemVerilogPreParser.Include_directiveContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SystemVerilogPreParser#level.
    def visitLevel(self, ctx:SystemVerilogPreParser.LevelContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SystemVerilogPreParser#line_directive.
    def visitLine_directive(self, ctx:SystemVerilogPreParser.Line_directiveContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SystemVerilogPreParser#line_directive_.
    def visitLine_directive_(self, ctx:SystemVerilogPreParser.Line_directive_Context):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SystemVerilogPreParser#macro_delimiter.
    def visitMacro_delimiter(self, ctx:SystemVerilogPreParser.Macro_delimiterContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SystemVerilogPreParser#macro_esc_newline.
    def visitMacro_esc_newline(self, ctx:SystemVerilogPreParser.Macro_esc_newlineContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SystemVerilogPreParser#macro_esc_quote.
    def visitMacro_esc_quote(self, ctx:SystemVerilogPreParser.Macro_esc_quoteContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SystemVerilogPreParser#macro_identifier.
    def visitMacro_identifier(self, ctx:SystemVerilogPreParser.Macro_identifierContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SystemVerilogPreParser#macro_name.
    def visitMacro_name(self, ctx:SystemVerilogPreParser.Macro_nameContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SystemVerilogPreParser#macro_quote.
    def visitMacro_quote(self, ctx:SystemVerilogPreParser.Macro_quoteContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SystemVerilogPreParser#macro_text.
    def visitMacro_text(self, ctx:SystemVerilogPreParser.Macro_textContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SystemVerilogPreParser#macro_text_.
    def visitMacro_text_(self, ctx:SystemVerilogPreParser.Macro_text_Context):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SystemVerilogPreParser#macro_usage.
    def visitMacro_usage(self, ctx:SystemVerilogPreParser.Macro_usageContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SystemVerilogPreParser#nounconnected_drive_directive.
    def visitNounconnected_drive_directive(self, ctx:SystemVerilogPreParser.Nounconnected_drive_directiveContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SystemVerilogPreParser#number.
    def visitNumber(self, ctx:SystemVerilogPreParser.NumberContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SystemVerilogPreParser#pragma_directive.
    def visitPragma_directive(self, ctx:SystemVerilogPreParser.Pragma_directiveContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SystemVerilogPreParser#pragma_expression.
    def visitPragma_expression(self, ctx:SystemVerilogPreParser.Pragma_expressionContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SystemVerilogPreParser#pragma_keyword.
    def visitPragma_keyword(self, ctx:SystemVerilogPreParser.Pragma_keywordContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SystemVerilogPreParser#pragma_name.
    def visitPragma_name(self, ctx:SystemVerilogPreParser.Pragma_nameContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SystemVerilogPreParser#pragma_value.
    def visitPragma_value(self, ctx:SystemVerilogPreParser.Pragma_valueContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SystemVerilogPreParser#resetall_directive.
    def visitResetall_directive(self, ctx:SystemVerilogPreParser.Resetall_directiveContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SystemVerilogPreParser#source_text_.
    def visitSource_text_(self, ctx:SystemVerilogPreParser.Source_text_Context):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SystemVerilogPreParser#string_literal.
    def visitString_literal(self, ctx:SystemVerilogPreParser.String_literalContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SystemVerilogPreParser#text_macro_definition.
    def visitText_macro_definition(self, ctx:SystemVerilogPreParser.Text_macro_definitionContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SystemVerilogPreParser#text_macro_usage.
    def visitText_macro_usage(self, ctx:SystemVerilogPreParser.Text_macro_usageContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SystemVerilogPreParser#time_precision.
    def visitTime_precision(self, ctx:SystemVerilogPreParser.Time_precisionContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SystemVerilogPreParser#time_unit.
    def visitTime_unit(self, ctx:SystemVerilogPreParser.Time_unitContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SystemVerilogPreParser#timescale_directive.
    def visitTimescale_directive(self, ctx:SystemVerilogPreParser.Timescale_directiveContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SystemVerilogPreParser#unconnected_drive_directive.
    def visitUnconnected_drive_directive(self, ctx:SystemVerilogPreParser.Unconnected_drive_directiveContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SystemVerilogPreParser#unconnected_drive_value.
    def visitUnconnected_drive_value(self, ctx:SystemVerilogPreParser.Unconnected_drive_valueContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SystemVerilogPreParser#undef_directive.
    def visitUndef_directive(self, ctx:SystemVerilogPreParser.Undef_directiveContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SystemVerilogPreParser#undefineall_directive.
    def visitUndefineall_directive(self, ctx:SystemVerilogPreParser.Undefineall_directiveContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SystemVerilogPreParser#version_specifier.
    def visitVersion_specifier(self, ctx:SystemVerilogPreParser.Version_specifierContext):
        return self.visitChildren(ctx)



del SystemVerilogPreParser