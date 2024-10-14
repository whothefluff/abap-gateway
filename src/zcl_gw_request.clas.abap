"! <p class="shorttext synchronized" lang="EN">Full Access Wrapper of a Gateway Request</p>
class zcl_gw_request definition
                     public
                     create public.

  public section.

    interfaces: zif_gw_request.

    aliases: original for zif_gw_request~original,
             details for zif_gw_request~details,
             tech_details for zif_gw_request~tech_details,
             model for zif_gw_request~model,
             current_entity_name for zif_gw_request~current_entity_name,
             current_entity_type for zif_gw_request~current_entity_type,
             key_tab for zif_gw_request~key_tab,
             matching_key_tab for zif_gw_request~matching_key_tab,
             filter_as_sql_where for zif_gw_request~filter_as_sql_where,
             sql_where for zif_gw_request~sql_where,
             sql_fields for zif_gw_request~sql_fields,
             navigation_target_sql_fields for zif_gw_request~navigation_target_sql_fields,
             navig_aware_source_sql_fields for zif_gw_request~navig_aware_source_sql_fields,
             throw_error_when_used for zif_gw_request~throw_error_when_used,
             current_entity_keys for zif_gw_request~current_entity_keys,
             mapped_with_current_key_values for zif_gw_request~mapped_with_current_key_values.

    "! <p class="shorttext synchronized" lang="EN">Creates a new wrapper</p>
    "!
    "! @parameter i_original_request | <p class="shorttext synchronized" lang="EN">Standard request</p>
    methods constructor
              importing
                i_original_request type zif_gw_request=>t_original_request.

  protected section.

    types: begin of t_sql_field_key,
           source type string,
           target type string,
         end of t_sql_field_key,
         begin of t_sql_field,
           key type zcl_gw_request=>t_sql_field_key,
           value type string,
         end of t_sql_field,
         t_sql_fields type hashed table of zcl_gw_request=>t_sql_field with unique key key.

    data an_original_request type zif_gw_request=>t_original_request.

    data a_lazy_detail_str type zif_gw_request=>t_details.

    data a_lazy_tech_detail_str type zif_gw_request=>t_tech_details.

    class-data a_sql_field_list type zcl_gw_request=>t_sql_fields.

  private section.

    data a_request_type_list type ref to request_types.

endclass.
class zcl_gw_request implementation.

  method constructor.

    me->an_original_request = i_original_request.

    me->a_request_type_list = new request_types( ).

  endmethod.
  method zif_gw_request~details.

    if me->a_lazy_detail_str is initial.

      me->a_lazy_detail_str = me->original( )->get_request_details( ).

    endif.

    r_val = me->a_lazy_detail_str.

  endmethod.
  method zif_gw_request~tech_details.

    if me->a_lazy_tech_detail_str is initial.

      me->a_lazy_tech_detail_str = me->details( )-technical_request.

    endif.

    r_val = me->a_lazy_tech_detail_str.

  endmethod.
  method zif_gw_request~model.

    cast /iwbep/if_mgw_req_key_convert( me->tech_details( )-key_converter )->get_entity_type( )->get_model( importing eo_model = r_val ).

  endmethod.
  method zif_gw_request~original.

    r_val = me->an_original_request.

  endmethod.
  method zif_gw_request~current_entity_name.

    r_val = me->tech_details( )-target_entity_set.

  endmethod.
  method zif_gw_request~current_entity_type.

    r_val = cast #( cast /iwbep/if_mgw_odata_fw_model( me->model( ) )->get_entity_type_by_set_name( conv #( me->current_entity_name( ) ) ) ).

  endmethod.
  method zif_gw_request~key_tab.

    r_val = corresponding #( me->details( )-key_tab ).

  endmethod.
  method zif_gw_request~matching_key_tab.

    types properties type sorted table of /iwbep/if_mgw_odata_fw_prop=>ty_s_mgw_odata_property with unique key name.

    data(current_entity_properties) = conv properties( cast /iwbep/if_mgw_odata_fw_etype( me->current_entity_type( ) )->get_properties( ) ).

    data(mapped_keys) = value zif_gw_request=>t_key_tab( let mapping_data = cond #( when i_mappings is bound
                                                                                    then i_mappings->data( ) ) in
                                                         for <key> in me->key_tab( )
                                                         ( value #( base <key>
                                                                    name = value #( mapping_data[ name = <key>-name ]-value default <key>-name ) ) ) ).

    r_val = filter #( mapped_keys in current_entity_properties where name eq name ).

  endmethod.
  method zif_gw_request~filter_as_sql_where.

    r_val = cast /iwbep/if_mgw_req_entityset( me->original( ) )->get_osql_where_clause( ).

  endmethod.
  method zif_gw_request~sql_where.

    data(filter_where) = me->filter_as_sql_where( ).

    r_val = cond #( when filter_where is not initial
                    then filter_where
                    else cond #( let keys = new zcl_gw_request( me->original( ) )->matching_key_tab( i_mappings ) in
                                 when keys is not initial
                                 then new zcl_name_value_pairs( corresponding #( keys ) )->as_sql_where( ) ) ).

  endmethod.
  method zif_gw_request~sql_fields.

    try.

      r_val = me->a_sql_field_list[ key = value #( source = me->tech_details( )-source_entity_set
                                                   target = me->tech_details( )-target_entity_set ) ]-value.

    catch cx_sy_itab_line_not_found.

      data(fields) = me->navig_aware_source_sql_fields( ).

      me->a_sql_field_list = value #( base me->a_sql_field_list
                                      ( key = value #( source = me->tech_details( )-source_entity_set
                                                       target = me->tech_details( )-target_entity_set )
                                        value = fields ) ).

      r_val = fields.

    endtry.

  endmethod.
  method zif_gw_request~throw_error_when_used.

    types: begin of method,
              parameters type sorted table of abap_parmdescr with unique key name
                                                             with non-unique sorted key by_kind components parm_kind,
              exceptions type abap_excpdescr_tab,
              name type abap_methname,
              for_event type abap_evntname,
              of_class type abap_classname,
              visibility type abap_visibility,
              is_interface type abap_bool,
              is_inherited type abap_bool,
              is_redefined type abap_bool,
              is_abstract type abap_bool,
              is_final type abap_bool,
              is_class type abap_bool,
              alias_for type abap_methname,
              is_raising_excps type abap_bool,
            end of method,
            methods type sorted table of method with unique key name.

    field-symbols <val> type any.

    data val type ref to data.

    data(original) = me->original( ).

    data(request_class) = cast cl_abap_objectdescr( cl_abap_typedescr=>describe_by_object_ref( original ) ).

    data(request_class_methods) = conv methods( request_class->methods ).

    data(request_interface) = me->a_request_type_list->intf_for( i_request_type ).

    data(parsed_methods) = value zif_gw_request=>t_forbidden_method_names( for <m> in i_methods
                                                                           ( request_interface && '~' && to_upper( <m> ) ) ).

    data(matching_methods) = filter #( request_class_methods in parsed_methods where name eq table_line ).

    data(forbidden_methods) = value forbidden_methods=>t_list( ).

    loop at matching_methods reference into data(method).

      data(returning_param) = method->*-parameters[ key by_kind
                                                    parm_kind = cl_abap_objectdescr=>returning ].

      data(method_param_type) = request_class->get_method_parameter_type( p_method_name = method->*-name
                                                                          p_parameter_name = returning_param-name ).

      create data val type handle method_param_type.

      data(tab) = value abap_parmbind_tab( ( name = returning_param-name
                                             kind = returning_param-parm_kind
                                             value = val ) ).

      call method original->(method->*-name)
        parameter-table tab.

      assign val->* to <val>.

      if <val> is not initial.

        forbidden_methods = value #( base forbidden_methods
                                     ( name = method->*-name
                                       ref = new zcx_gw_server( i_http_response_status = zcx_gw_server=>not_implemented
                                                                i_t100_message = new zcl_free_message( `Query option ` && replace( val = method->*-name
                                                                                                                                   sub = request_interface && `~GET_`
                                                                                                                                   with = `` ) && ` not implemented in ` && me->current_entity_name( ) ) ) ) ) ##NO_TEXT.

      endif.

    endloop.

    if forbidden_methods is not initial.

      raise exception type forbidden_methods exporting i_list = forbidden_methods.

    endif.

  endmethod.
  method zif_gw_request~current_entity_keys.

    r_val = value #( for <prop> in me->model( )->get_properties_of_entity( me->current_entity_type( )->get_id( ) )
                     where ( is_key = abap_true )
                     ( <prop> ) ).

  endmethod.
  method zif_gw_request~navigation_target_sql_fields.

    data(target_fields) = value string_table( ).

    loop at cast /iwbep/if_mgw_req_entityset( me->original( ) )->get_select_with_mandtry_fields( ) reference into data(field).

      split field->* at `/` into table data(segments).

      if lines( segments ) gt 1.

        target_fields = value #( base target_fields
                                 ( segments[ 2 ] ) ).

      endif.

    endloop.

    r_val = concat_lines_of( table = target_fields
                             sep = `, ` ).

  endmethod.
  method zif_gw_request~navig_aware_source_sql_fields.

    data(source_fields) = value string_table( ).

    loop at cast /iwbep/if_mgw_req_entityset( me->original( ) )->get_select_with_mandtry_fields( ) reference into data(field).

      split field->* at `/` into table data(segments).

      if lines( segments ) eq 1.

        source_fields = value #( base source_fields
                                 ( segments[ 1 ] ) ).

      endif.

    endloop.

    r_val = concat_lines_of( table = source_fields
                             sep = `, ` ).

  endmethod.
  method zif_gw_request~mapped_with_current_key_values.

    data(key_properties) = me->current_entity_keys( ).

    data(key_values) = me->key_tab( ).

    loop at key_properties reference into data(property).

      assign component property->*-external_name of structure i_data to field-symbol(<value>).

      <value> = key_values[ name = property->*-external_name ]-value.

    endloop.

    r_val = new zcl_data_object_copy( i_data )->ref( ).

  endmethod.

endclass.
