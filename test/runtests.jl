using Libfive
using Test

@testset "Libfive.jl" begin
    # All of these trees are manually managed and must be freed
    # In higher-level languages, freeing can be attached to the object's
    # destructor and run during garbage collection.
    x = Libfive.libfive_tree_x()
    y = Libfive.libfive_tree_y()
    
    x2 = Libfive.libfive_tree_unary( Libfive.libfive_opcode_enum("square"), x)
    y2 = Libfive.libfive_tree_unary( Libfive.libfive_opcode_enum("square"), y)
    s  = Libfive.libfive_tree_binary(Libfive.libfive_opcode_enum("add"), x2, y2)
    
    one = Libfive.libfive_tree_const(1)
    out = Libfive.libfive_tree_binary(Libfive.libfive_opcode_enum("sub"), s, one)
    
    # Select a 2D region to export, then write an SVG
    R = Libfive.libfive_region2(Libfive.libfive_interval(-2,2), Libfive.libfive_interval(-2,2))

    Libfive.libfive_tree_save_slice(out, R, 0, 10, "circle.svg");
    
    # Finally, clean up all of the intermediate trees
    #Libfive.libfive_tree_free(x);
    #Libfive.libfive_tree_free(y);
    #Libfive.libfive_tree_free(x2);
    #Libfive.libfive_tree_free(y2);
    #Libfive.libfive_tree_free(s);
    #Libfive.libfive_tree_free(one);
    #Libfive.libfive_tree_free(out);
end
