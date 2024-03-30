# Generated from VerilogPreParser.g4 by ANTLR 4.7.2
from antlr4 import *
if __name__ is not None and "." in __name__:
    from .VerilogPreParser import VerilogPreParser
else:
    from VerilogPreParser import VerilogPreParser

# This class defines a complete listener for a parse tree produced by VerilogPreParser.
class VerilogPreParserListener(ParseTreeListener):

    # Enter a parse tree produced by VerilogPreParser#source_text.
    def enterSource_text(self, ctx:VerilogPreParser.Source_textContext):
        pass

    # Exit a parse tree produced by VerilogPreParser#source_text.
    def exitSource_text(self, ctx:VerilogPreParser.Source_textContext):
        pass


    # Enter a parse tree produced by VerilogPreParser#compiler_directive.
    def enterCompiler_directive(self, ctx:VerilogPreParser.Compiler_directiveContext):
        pass

    # Exit a parse tree produced by VerilogPreParser#compiler_directive.
    def exitCompiler_directive(self, ctx:VerilogPreParser.Compiler_directiveContext):
        pass


    # Enter a parse tree produced by VerilogPreParser#begin_keywords_directive.
    def enterBegin_keywords_directive(self, ctx:VerilogPreParser.Begin_keywords_directiveContext):
        pass

    # Exit a parse tree produced by VerilogPreParser#begin_keywords_directive.
    def exitBegin_keywords_directive(self, ctx:VerilogPreParser.Begin_keywords_directiveContext):
        pass


    # Enter a parse tree produced by VerilogPreParser#celldefine_directive.
    def enterCelldefine_directive(self, ctx:VerilogPreParser.Celldefine_directiveContext):
        pass

    # Exit a parse tree produced by VerilogPreParser#celldefine_directive.
    def exitCelldefine_directive(self, ctx:VerilogPreParser.Celldefine_directiveContext):
        pass


    # Enter a parse tree produced by VerilogPreParser#default_nettype_directive.
    def enterDefault_nettype_directive(self, ctx:VerilogPreParser.Default_nettype_directiveContext):
        pass

    # Exit a parse tree produced by VerilogPreParser#default_nettype_directive.
    def exitDefault_nettype_directive(self, ctx:VerilogPreParser.Default_nettype_directiveContext):
        pass


    # Enter a parse tree produced by VerilogPreParser#default_nettype_value.
    def enterDefault_nettype_value(self, ctx:VerilogPreParser.Default_nettype_valueContext):
        pass

    # Exit a parse tree produced by VerilogPreParser#default_nettype_value.
    def exitDefault_nettype_value(self, ctx:VerilogPreParser.Default_nettype_valueContext):
        pass


    # Enter a parse tree produced by VerilogPreParser#else_directive.
    def enterElse_directive(self, ctx:VerilogPreParser.Else_directiveContext):
        pass

    # Exit a parse tree produced by VerilogPreParser#else_directive.
    def exitElse_directive(self, ctx:VerilogPreParser.Else_directiveContext):
        pass


    # Enter a parse tree produced by VerilogPreParser#elsif_directive.
    def enterElsif_directive(self, ctx:VerilogPreParser.Elsif_directiveContext):
        pass

    # Exit a parse tree produced by VerilogPreParser#elsif_directive.
    def exitElsif_directive(self, ctx:VerilogPreParser.Elsif_directiveContext):
        pass


    # Enter a parse tree produced by VerilogPreParser#end_keywords_directive.
    def enterEnd_keywords_directive(self, ctx:VerilogPreParser.End_keywords_directiveContext):
        pass

    # Exit a parse tree produced by VerilogPreParser#end_keywords_directive.
    def exitEnd_keywords_directive(self, ctx:VerilogPreParser.End_keywords_directiveContext):
        pass


    # Enter a parse tree produced by VerilogPreParser#endcelldefine_directive.
    def enterEndcelldefine_directive(self, ctx:VerilogPreParser.Endcelldefine_directiveContext):
        pass

    # Exit a parse tree produced by VerilogPreParser#endcelldefine_directive.
    def exitEndcelldefine_directive(self, ctx:VerilogPreParser.Endcelldefine_directiveContext):
        pass


    # Enter a parse tree produced by VerilogPreParser#endif_directive.
    def enterEndif_directive(self, ctx:VerilogPreParser.Endif_directiveContext):
        pass

    # Exit a parse tree produced by VerilogPreParser#endif_directive.
    def exitEndif_directive(self, ctx:VerilogPreParser.Endif_directiveContext):
        pass


    # Enter a parse tree produced by VerilogPreParser#filename.
    def enterFilename(self, ctx:VerilogPreParser.FilenameContext):
        pass

    # Exit a parse tree produced by VerilogPreParser#filename.
    def exitFilename(self, ctx:VerilogPreParser.FilenameContext):
        pass


    # Enter a parse tree produced by VerilogPreParser#group_of_lines.
    def enterGroup_of_lines(self, ctx:VerilogPreParser.Group_of_linesContext):
        pass

    # Exit a parse tree produced by VerilogPreParser#group_of_lines.
    def exitGroup_of_lines(self, ctx:VerilogPreParser.Group_of_linesContext):
        pass


    # Enter a parse tree produced by VerilogPreParser#identifier.
    def enterIdentifier(self, ctx:VerilogPreParser.IdentifierContext):
        pass

    # Exit a parse tree produced by VerilogPreParser#identifier.
    def exitIdentifier(self, ctx:VerilogPreParser.IdentifierContext):
        pass


    # Enter a parse tree produced by VerilogPreParser#ifdef_directive.
    def enterIfdef_directive(self, ctx:VerilogPreParser.Ifdef_directiveContext):
        pass

    # Exit a parse tree produced by VerilogPreParser#ifdef_directive.
    def exitIfdef_directive(self, ctx:VerilogPreParser.Ifdef_directiveContext):
        pass


    # Enter a parse tree produced by VerilogPreParser#ifndef_directive.
    def enterIfndef_directive(self, ctx:VerilogPreParser.Ifndef_directiveContext):
        pass

    # Exit a parse tree produced by VerilogPreParser#ifndef_directive.
    def exitIfndef_directive(self, ctx:VerilogPreParser.Ifndef_directiveContext):
        pass


    # Enter a parse tree produced by VerilogPreParser#include_directive.
    def enterInclude_directive(self, ctx:VerilogPreParser.Include_directiveContext):
        pass

    # Exit a parse tree produced by VerilogPreParser#include_directive.
    def exitInclude_directive(self, ctx:VerilogPreParser.Include_directiveContext):
        pass


    # Enter a parse tree produced by VerilogPreParser#level.
    def enterLevel(self, ctx:VerilogPreParser.LevelContext):
        pass

    # Exit a parse tree produced by VerilogPreParser#level.
    def exitLevel(self, ctx:VerilogPreParser.LevelContext):
        pass


    # Enter a parse tree produced by VerilogPreParser#line_directive.
    def enterLine_directive(self, ctx:VerilogPreParser.Line_directiveContext):
        pass

    # Exit a parse tree produced by VerilogPreParser#line_directive.
    def exitLine_directive(self, ctx:VerilogPreParser.Line_directiveContext):
        pass


    # Enter a parse tree produced by VerilogPreParser#macro_delimiter.
    def enterMacro_delimiter(self, ctx:VerilogPreParser.Macro_delimiterContext):
        pass

    # Exit a parse tree produced by VerilogPreParser#macro_delimiter.
    def exitMacro_delimiter(self, ctx:VerilogPreParser.Macro_delimiterContext):
        pass


    # Enter a parse tree produced by VerilogPreParser#macro_esc_newline.
    def enterMacro_esc_newline(self, ctx:VerilogPreParser.Macro_esc_newlineContext):
        pass

    # Exit a parse tree produced by VerilogPreParser#macro_esc_newline.
    def exitMacro_esc_newline(self, ctx:VerilogPreParser.Macro_esc_newlineContext):
        pass


    # Enter a parse tree produced by VerilogPreParser#macro_esc_quote.
    def enterMacro_esc_quote(self, ctx:VerilogPreParser.Macro_esc_quoteContext):
        pass

    # Exit a parse tree produced by VerilogPreParser#macro_esc_quote.
    def exitMacro_esc_quote(self, ctx:VerilogPreParser.Macro_esc_quoteContext):
        pass


    # Enter a parse tree produced by VerilogPreParser#macro_identifier.
    def enterMacro_identifier(self, ctx:VerilogPreParser.Macro_identifierContext):
        pass

    # Exit a parse tree produced by VerilogPreParser#macro_identifier.
    def exitMacro_identifier(self, ctx:VerilogPreParser.Macro_identifierContext):
        pass


    # Enter a parse tree produced by VerilogPreParser#macro_name.
    def enterMacro_name(self, ctx:VerilogPreParser.Macro_nameContext):
        pass

    # Exit a parse tree produced by VerilogPreParser#macro_name.
    def exitMacro_name(self, ctx:VerilogPreParser.Macro_nameContext):
        pass


    # Enter a parse tree produced by VerilogPreParser#macro_quote.
    def enterMacro_quote(self, ctx:VerilogPreParser.Macro_quoteContext):
        pass

    # Exit a parse tree produced by VerilogPreParser#macro_quote.
    def exitMacro_quote(self, ctx:VerilogPreParser.Macro_quoteContext):
        pass


    # Enter a parse tree produced by VerilogPreParser#macro_text.
    def enterMacro_text(self, ctx:VerilogPreParser.Macro_textContext):
        pass

    # Exit a parse tree produced by VerilogPreParser#macro_text.
    def exitMacro_text(self, ctx:VerilogPreParser.Macro_textContext):
        pass


    # Enter a parse tree produced by VerilogPreParser#macro_text_.
    def enterMacro_text_(self, ctx:VerilogPreParser.Macro_text_Context):
        pass

    # Exit a parse tree produced by VerilogPreParser#macro_text_.
    def exitMacro_text_(self, ctx:VerilogPreParser.Macro_text_Context):
        pass


    # Enter a parse tree produced by VerilogPreParser#macro_usage.
    def enterMacro_usage(self, ctx:VerilogPreParser.Macro_usageContext):
        pass

    # Exit a parse tree produced by VerilogPreParser#macro_usage.
    def exitMacro_usage(self, ctx:VerilogPreParser.Macro_usageContext):
        pass


    # Enter a parse tree produced by VerilogPreParser#nounconnected_drive_directive.
    def enterNounconnected_drive_directive(self, ctx:VerilogPreParser.Nounconnected_drive_directiveContext):
        pass

    # Exit a parse tree produced by VerilogPreParser#nounconnected_drive_directive.
    def exitNounconnected_drive_directive(self, ctx:VerilogPreParser.Nounconnected_drive_directiveContext):
        pass


    # Enter a parse tree produced by VerilogPreParser#number.
    def enterNumber(self, ctx:VerilogPreParser.NumberContext):
        pass

    # Exit a parse tree produced by VerilogPreParser#number.
    def exitNumber(self, ctx:VerilogPreParser.NumberContext):
        pass


    # Enter a parse tree produced by VerilogPreParser#pragma_directive.
    def enterPragma_directive(self, ctx:VerilogPreParser.Pragma_directiveContext):
        pass

    # Exit a parse tree produced by VerilogPreParser#pragma_directive.
    def exitPragma_directive(self, ctx:VerilogPreParser.Pragma_directiveContext):
        pass


    # Enter a parse tree produced by VerilogPreParser#pragma_expression.
    def enterPragma_expression(self, ctx:VerilogPreParser.Pragma_expressionContext):
        pass

    # Exit a parse tree produced by VerilogPreParser#pragma_expression.
    def exitPragma_expression(self, ctx:VerilogPreParser.Pragma_expressionContext):
        pass


    # Enter a parse tree produced by VerilogPreParser#pragma_keyword.
    def enterPragma_keyword(self, ctx:VerilogPreParser.Pragma_keywordContext):
        pass

    # Exit a parse tree produced by VerilogPreParser#pragma_keyword.
    def exitPragma_keyword(self, ctx:VerilogPreParser.Pragma_keywordContext):
        pass


    # Enter a parse tree produced by VerilogPreParser#pragma_name.
    def enterPragma_name(self, ctx:VerilogPreParser.Pragma_nameContext):
        pass

    # Exit a parse tree produced by VerilogPreParser#pragma_name.
    def exitPragma_name(self, ctx:VerilogPreParser.Pragma_nameContext):
        pass


    # Enter a parse tree produced by VerilogPreParser#pragma_value.
    def enterPragma_value(self, ctx:VerilogPreParser.Pragma_valueContext):
        pass

    # Exit a parse tree produced by VerilogPreParser#pragma_value.
    def exitPragma_value(self, ctx:VerilogPreParser.Pragma_valueContext):
        pass


    # Enter a parse tree produced by VerilogPreParser#resetall_directive.
    def enterResetall_directive(self, ctx:VerilogPreParser.Resetall_directiveContext):
        pass

    # Exit a parse tree produced by VerilogPreParser#resetall_directive.
    def exitResetall_directive(self, ctx:VerilogPreParser.Resetall_directiveContext):
        pass


    # Enter a parse tree produced by VerilogPreParser#source_text_.
    def enterSource_text_(self, ctx:VerilogPreParser.Source_text_Context):
        pass

    # Exit a parse tree produced by VerilogPreParser#source_text_.
    def exitSource_text_(self, ctx:VerilogPreParser.Source_text_Context):
        pass


    # Enter a parse tree produced by VerilogPreParser#string_.
    def enterString_(self, ctx:VerilogPreParser.String_Context):
        pass

    # Exit a parse tree produced by VerilogPreParser#string_.
    def exitString_(self, ctx:VerilogPreParser.String_Context):
        pass


    # Enter a parse tree produced by VerilogPreParser#text_macro_definition.
    def enterText_macro_definition(self, ctx:VerilogPreParser.Text_macro_definitionContext):
        pass

    # Exit a parse tree produced by VerilogPreParser#text_macro_definition.
    def exitText_macro_definition(self, ctx:VerilogPreParser.Text_macro_definitionContext):
        pass


    # Enter a parse tree produced by VerilogPreParser#text_macro_usage.
    def enterText_macro_usage(self, ctx:VerilogPreParser.Text_macro_usageContext):
        pass

    # Exit a parse tree produced by VerilogPreParser#text_macro_usage.
    def exitText_macro_usage(self, ctx:VerilogPreParser.Text_macro_usageContext):
        pass


    # Enter a parse tree produced by VerilogPreParser#time_precision.
    def enterTime_precision(self, ctx:VerilogPreParser.Time_precisionContext):
        pass

    # Exit a parse tree produced by VerilogPreParser#time_precision.
    def exitTime_precision(self, ctx:VerilogPreParser.Time_precisionContext):
        pass


    # Enter a parse tree produced by VerilogPreParser#time_unit.
    def enterTime_unit(self, ctx:VerilogPreParser.Time_unitContext):
        pass

    # Exit a parse tree produced by VerilogPreParser#time_unit.
    def exitTime_unit(self, ctx:VerilogPreParser.Time_unitContext):
        pass


    # Enter a parse tree produced by VerilogPreParser#timescale_directive.
    def enterTimescale_directive(self, ctx:VerilogPreParser.Timescale_directiveContext):
        pass

    # Exit a parse tree produced by VerilogPreParser#timescale_directive.
    def exitTimescale_directive(self, ctx:VerilogPreParser.Timescale_directiveContext):
        pass


    # Enter a parse tree produced by VerilogPreParser#unconnected_drive_directive.
    def enterUnconnected_drive_directive(self, ctx:VerilogPreParser.Unconnected_drive_directiveContext):
        pass

    # Exit a parse tree produced by VerilogPreParser#unconnected_drive_directive.
    def exitUnconnected_drive_directive(self, ctx:VerilogPreParser.Unconnected_drive_directiveContext):
        pass


    # Enter a parse tree produced by VerilogPreParser#unconnected_drive_value.
    def enterUnconnected_drive_value(self, ctx:VerilogPreParser.Unconnected_drive_valueContext):
        pass

    # Exit a parse tree produced by VerilogPreParser#unconnected_drive_value.
    def exitUnconnected_drive_value(self, ctx:VerilogPreParser.Unconnected_drive_valueContext):
        pass


    # Enter a parse tree produced by VerilogPreParser#undef_directive.
    def enterUndef_directive(self, ctx:VerilogPreParser.Undef_directiveContext):
        pass

    # Exit a parse tree produced by VerilogPreParser#undef_directive.
    def exitUndef_directive(self, ctx:VerilogPreParser.Undef_directiveContext):
        pass


    # Enter a parse tree produced by VerilogPreParser#version_specifier.
    def enterVersion_specifier(self, ctx:VerilogPreParser.Version_specifierContext):
        pass

    # Exit a parse tree produced by VerilogPreParser#version_specifier.
    def exitVersion_specifier(self, ctx:VerilogPreParser.Version_specifierContext):
        pass


