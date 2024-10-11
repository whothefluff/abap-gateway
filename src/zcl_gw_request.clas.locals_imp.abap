*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
class forbidden_methods implementation.

  method constructor.

    super->constructor( i_http_response_status = zcx_gw_server=>not_implemented
                        i_t100_message = new zcl_text_symbol_message( 'Some query options are not allowed, check exception object'(001) ) ).

    me->a_list = i_list.

  endmethod.
  method list.

    r_val = me->a_list.

  endmethod.

endclass.
class request_types implementation.

  method intf_for.

    r_val = request_types=>a_list[ name = i_name ]-interface_name.

  endmethod.
  method class_constructor.

    request_types=>a_list = value #( ( request_types=>create_entity )
                                     ( request_types=>read_entity )
                                     ( request_types=>entity_set )
                                     ( request_types=>update_entity )
                                     ( request_types=>patch_entity )
                                     ( request_types=>delete_entity ) ).

  endmethod.

endclass.
