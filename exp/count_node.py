from antlr4 import *
from antlr4_verilog import InputStream, CommonTokenStream, ParseTreeWalker
from antlr4_verilog.verilog import VerilogLexer, VerilogParser, VerilogParserListener, VerilogParserVisitor
import antlr4
from io import StringIO
import os

# Visitor to build the hierarchy of modules and count instances
class ModuleCounterVisitor(VerilogParserVisitor):
    def __init__(self):
        self.modules = {}
        self.current_module = None

    # Visit a parse tree produced by VerilogParser#module_declaration.
    def visitModule_declaration(self, ctx):
        module_name = ctx.module_identifier().getText()
        self.current_module = module_name
        self.modules[module_name] = []
        self.visitChildren(ctx)
        self.current_module = None
        return self.modules

    # Visit a parse tree produced by VerilogParser#module_instantiation.
    def visitModule_instantiation(self, ctx):
        instance_module_name = ctx.module_identifier().getText()
        if self.current_module:
            self.modules[self.current_module].append(instance_module_name)
        return self.visitChildren(ctx)

# Recursive function to count module instances
def count_module_instances(modules, module_name):
    if module_name not in modules or not modules[module_name]:
        return 1
    count = 1  # Count the current instance
    for submodule_name in modules[module_name]:
        count += count_module_instances(modules, submodule_name)  # Recursively count submodules
    return count

# Read the Verilog code and parse it
input_stream = FileStream('tests/regression/b20/b20.v')
lexer = VerilogLexer(input_stream)
stream = CommonTokenStream(lexer)
parser = VerilogParser(stream)
tree = parser.source_text()

# Use the visitor to traverse the tree
visitor = ModuleCounterVisitor()
visitor.visit(tree)

# Now we have the module counts in visitor.modules
# Start counting from the top module 'adder_32bit'
total_instances = count_module_instances(visitor.modules, 'b20') - 1  # Subtract 1 to exclude the top module itself from the count

print(f"Total number of instances: {total_instances}")