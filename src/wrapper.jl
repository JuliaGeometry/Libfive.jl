using CEnum

struct libfive_interval
    lower::Cfloat
    upper::Cfloat
end

struct libfive_region2
    X::libfive_interval
    Y::libfive_interval
end

struct libfive_region3
    X::libfive_interval
    Y::libfive_interval
    Z::libfive_interval
end

struct libfive_vec2
    x::Cfloat
    y::Cfloat
end

struct libfive_vec3
    x::Cfloat
    y::Cfloat
    z::Cfloat
end

struct libfive_vec4
    x::Cfloat
    y::Cfloat
    z::Cfloat
    w::Cfloat
end

struct libfive_tri
    a::UInt32
    b::UInt32
    c::UInt32
end

struct libfive_contour
    pts::Ptr{libfive_vec2}
    count::UInt32
end

struct libfive_contours
    cs::Ptr{libfive_contour}
    count::UInt32
end

struct libfive_contour3
    pts::Ptr{libfive_vec3}
    count::UInt32
end

struct libfive_contours3
    cs::Ptr{libfive_contour3}
    count::UInt32
end

struct libfive_mesh
    verts::Ptr{libfive_vec3}
    tris::Ptr{libfive_tri}
    tri_count::UInt32
    vert_count::UInt32
end

struct libfive_mesh_coords
    verts::Ptr{libfive_vec3}
    vert_count::UInt32
    coord_indices::Ptr{Int32}
    coord_index_count::UInt32
end

struct libfive_pixels
    pixels::Ptr{Bool}
    width::UInt32
    height::UInt32
end

function libfive_contours_delete(cs)
    ccall((:libfive_contours_delete, libfive), Cvoid, (Ptr{libfive_contours},), cs)
end

function libfive_contours3_delete(cs)
    ccall((:libfive_contours3_delete, libfive), Cvoid, (Ptr{libfive_contours3},), cs)
end

function libfive_mesh_delete(m)
    ccall((:libfive_mesh_delete, libfive), Cvoid, (Ptr{libfive_mesh},), m)
end

function libfive_mesh_coords_delete(m)
    ccall((:libfive_mesh_coords_delete, libfive), Cvoid, (Ptr{libfive_mesh_coords},), m)
end

function libfive_pixels_delete(ps)
    ccall((:libfive_pixels_delete, libfive), Cvoid, (Ptr{libfive_pixels},), ps)
end

function libfive_opcode_enum(op)
    ccall((:libfive_opcode_enum, libfive), Cint, (Ptr{Cchar},), op)
end

function libfive_opcode_args(op)
    ccall((:libfive_opcode_args, libfive), Cint, (Cint,), op)
end

struct libfive_vars
    vars::Ptr{Ptr{Cvoid}}
    values::Ptr{Cfloat}
    size::UInt32
end

function libfive_vars_delete(j)
    ccall((:libfive_vars_delete, libfive), Cvoid, (Ptr{libfive_vars},), j)
end

mutable struct libfive_tree_ end

const libfive_tree = Ptr{libfive_tree_}

mutable struct libfive_evaluator_ end

const libfive_evaluator = Ptr{libfive_evaluator_}

# no prototype is found for this function at libfive.h:197:14, please use with caution
function libfive_tree_x()
    ccall((:libfive_tree_x, libfive), libfive_tree, ())
end

# no prototype is found for this function at libfive.h:202:14, please use with caution
function libfive_tree_y()
    ccall((:libfive_tree_y, libfive), libfive_tree, ())
end

# no prototype is found for this function at libfive.h:207:14, please use with caution
function libfive_tree_z()
    ccall((:libfive_tree_z, libfive), libfive_tree, ())
end

# no prototype is found for this function at libfive.h:212:14, please use with caution
function libfive_tree_var()
    ccall((:libfive_tree_var, libfive), libfive_tree, ())
end

function libfive_tree_is_var(t)
    ccall((:libfive_tree_is_var, libfive), Bool, (libfive_tree,), t)
end

function libfive_tree_const(f)
    ccall((:libfive_tree_const, libfive), libfive_tree, (Cfloat,), f)
end

function libfive_tree_get_const(t, success)
    ccall((:libfive_tree_get_const, libfive), Cfloat, (libfive_tree, Ptr{Bool}), t, success)
end

function libfive_tree_nullary(op)
    ccall((:libfive_tree_nullary, libfive), libfive_tree, (Cint,), op)
end

function libfive_tree_unary(op, a)
    ccall((:libfive_tree_unary, libfive), libfive_tree, (Cint, libfive_tree), op, a)
end

function libfive_tree_binary(op, a, b)
    ccall((:libfive_tree_binary, libfive), libfive_tree, (Cint, libfive_tree, libfive_tree), op, a, b)
end

function libfive_tree_id(t)
    ccall((:libfive_tree_id, libfive), Ptr{Cvoid}, (libfive_tree,), t)
end

function libfive_tree_eval_f(t, p)
    ccall((:libfive_tree_eval_f, libfive), Cfloat, (libfive_tree, libfive_vec3), t, p)
end

function libfive_tree_eval_r(t, r)
    ccall((:libfive_tree_eval_r, libfive), libfive_interval, (libfive_tree, libfive_region3), t, r)
end

function libfive_tree_eval_d(t, p)
    ccall((:libfive_tree_eval_d, libfive), libfive_vec3, (libfive_tree, libfive_vec3), t, p)
end

function libfive_tree_delete(ptr)
    ccall((:libfive_tree_delete, libfive), Cvoid, (libfive_tree,), ptr)
end

function libfive_tree_save(ptr, filename)
    ccall((:libfive_tree_save, libfive), Bool, (libfive_tree, Ptr{Cchar}), ptr, filename)
end

function libfive_tree_load(filename)
    ccall((:libfive_tree_load, libfive), libfive_tree, (Ptr{Cchar},), filename)
end

function libfive_tree_remap(p, x, y, z)
    ccall((:libfive_tree_remap, libfive), libfive_tree, (libfive_tree, libfive_tree, libfive_tree, libfive_tree), p, x, y, z)
end

function libfive_tree_optimized(t)
    ccall((:libfive_tree_optimized, libfive), libfive_tree, (libfive_tree,), t)
end

function libfive_tree_print(t)
    ccall((:libfive_tree_print, libfive), Ptr{Cchar}, (libfive_tree,), t)
end

function libfive_free_str(ptr)
    ccall((:libfive_free_str, libfive), Cvoid, (Ptr{Cchar},), ptr)
end

function libfive_tree_render_slice(tree, R, z, res)
    ccall((:libfive_tree_render_slice, libfive), Ptr{libfive_contours}, (libfive_tree, libfive_region2, Cfloat, Cfloat), tree, R, z, res)
end

function libfive_tree_render_slice3(tree, R, z, res)
    ccall((:libfive_tree_render_slice3, libfive), Ptr{libfive_contours3}, (libfive_tree, libfive_region2, Cfloat, Cfloat), tree, R, z, res)
end

function libfive_tree_save_slice(tree, R, z, res, f)
    ccall((:libfive_tree_save_slice, libfive), Cvoid, (libfive_tree, libfive_region2, Cfloat, Cfloat, Ptr{Cchar}), tree, R, z, res, f)
end

function libfive_tree_render_mesh(tree, R, res)
    ccall((:libfive_tree_render_mesh, libfive), Ptr{libfive_mesh}, (libfive_tree, libfive_region3, Cfloat), tree, R, res)
end

function libfive_tree_render_mesh_coords(tree, R, res)
    ccall((:libfive_tree_render_mesh_coords, libfive), Ptr{libfive_mesh_coords}, (libfive_tree, libfive_region3, Cfloat), tree, R, res)
end

function libfive_tree_save_mesh(tree, R, res, f)
    ccall((:libfive_tree_save_mesh, libfive), Bool, (libfive_tree, libfive_region3, Cfloat, Ptr{Cchar}), tree, R, res, f)
end

function libfive_evaluator_save_mesh(evaluator, R, f)
    ccall((:libfive_evaluator_save_mesh, libfive), Bool, (libfive_evaluator, libfive_region3, Ptr{Cchar}), evaluator, R, f)
end

function libfive_tree_save_meshes(trees, R, res, quality, f)
    ccall((:libfive_tree_save_meshes, libfive), Bool, (Ptr{libfive_tree}, libfive_region3, Cfloat, Cfloat, Ptr{Cchar}), trees, R, res, quality, f)
end

function libfive_tree_render_pixels(tree, R, z, res)
    ccall((:libfive_tree_render_pixels, libfive), Ptr{libfive_pixels}, (libfive_tree, libfive_region2, Cfloat, Cfloat), tree, R, z, res)
end

function libfive_tree_evaluator(tree, vars)
    ccall((:libfive_tree_evaluator, libfive), libfive_evaluator, (libfive_tree, libfive_vars), tree, vars)
end

function libfive_evaluator_update_vars(eval_tree, vars)
    ccall((:libfive_evaluator_update_vars, libfive), Bool, (libfive_evaluator, libfive_vars), eval_tree, vars)
end

function libfive_evaluator_delete(ptr)
    ccall((:libfive_evaluator_delete, libfive), Cvoid, (libfive_evaluator,), ptr)
end

function libfive_git_version()
    ccall((:libfive_git_version, libfive), Ptr{Cchar}, ())
end

function libfive_git_revision()
    ccall((:libfive_git_revision, libfive), Ptr{Cchar}, ())
end

function libfive_git_branch()
    ccall((:libfive_git_branch, libfive), Ptr{Cchar}, ())
end

