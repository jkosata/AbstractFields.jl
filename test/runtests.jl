using AbstractFields, Test

@with_fields abs_type custom_float::Float64 custom_int::Int

@abs_type struct new_type
    orig_field::Dict
end

@test fieldtype(new_type, :orig_field) == Dict
@test fieldtype(new_type, :custom_float) == Float64
@test fieldtype(new_type, :custom_int) == Int

new_inst = new_type(Dict(), 1.0, 2)
@test new_inst isa abs_type

@test_throws "syntax: duplicate" @macroexpand @abs_type struct invalid_type; custom_int::Int end

@with_fields abs_type_weak custom_float custom_int

@abs_type_weak struct new_type_weak
    orig_field::Dict
end

@test fieldtype(new_type_weak, :custom_float) == Any
@test fieldtype(new_type_weak, :custom_int) == Any

@test_throws "syntax: duplicate" @macroexpand @abs_type_weak struct invalid_type; custom_int end

@test_throws "syntax: duplicate" @macroexpand @with_fields invalid_type custom_field custom_field
