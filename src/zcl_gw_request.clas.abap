"! <p class="shorttext synchronized" lang="EN">Full Access Wrapper of a Gateway Request</p>
class zcl_gw_request definition
                     public
                     create public.

  public section.

    types t_original_request type ref to /iwbep/cl_mgw_request.

    types t_details type /iwbep/if_mgw_core_srv_runtime=>ty_s_mgw_request_context.

    types t_tech_details type zcl_gw_request=>t_details-technical_request.

    types t_model type ref to /iwbep/cl_mgw_odata_model.

    types t_entity_type type ref to /iwbep/cl_mgw_odata_entity_typ.

    types t_entity_keys type /iwbep/if_mgw_med_odata_types=>ty_t_med_properties.

    types: begin of t_key_entry,
             name type /iwbep/med_external_name,
             value type string,
           end of t_key_entry,
           t_key_tab type sorted table of zcl_gw_request=>t_key_entry with unique key name.

    "! <p class="shorttext synchronized" lang="EN">Creates a new wrapper</p>
    "!
    "! @parameter i_original_request | <p class="shorttext synchronized" lang="EN">Standard request</p>
    methods constructor
              importing
                i_original_request type zcl_gw_request=>t_original_request.

    "! <p class="shorttext synchronized" lang="EN">Returns the standard request</p>
    "!
    "! @parameter r_val | <p class="shorttext synchronized" lang="EN">Wrapped request</p>
    methods original
              returning
                value(r_val) type zcl_gw_request=>t_original_request.

    "! <p class="shorttext synchronized" lang="EN">Returns the data of the request</p>
    "!
    "! @parameter r_val | <p class="shorttext synchronized" lang="EN">Request data</p>
    methods details
              returning
                value(r_val) type zcl_gw_request=>t_details.

    "! <p class="shorttext synchronized" lang="EN">Returns the technical data of the request</p>
    "!
    "! @parameter r_val | <p class="shorttext synchronized" lang="EN">Technical data</p>
    methods tech_details
              returning
                value(r_val) type zcl_gw_request=>t_tech_details.

    "! <p class="shorttext synchronized" lang="EN">Returns the model associated with the request</p>
    "!
    "! @parameter r_val | <p class="shorttext synchronized" lang="EN">Model</p>
    methods model
              returning
                value(r_val) type zcl_gw_request=>t_model.

    "! <p class="shorttext synchronized" lang="EN">Returns the entity name of the current request</p>
    "!
    "! @parameter r_val | <p class="shorttext synchronized" lang="EN">Entity name</p>
    methods current_entity_name
              returning
                value(r_val) type string.

    "! <p class="shorttext synchronized" lang="EN">Returns the entity type of the current request</p>
    "!
    "! @parameter r_val | <p class="shorttext synchronized" lang="EN">Entity type</p>
    "! @raising /iwbep/cx_mgw_med_exception | <p class="shorttext synchronized" lang="EN">Meta data exception</p>
    methods current_entity_type
              returning
                value(r_val) type zcl_gw_request=>t_entity_type
              raising
                 /iwbep/cx_mgw_med_exception.

    "! <p class="shorttext synchronized" lang="EN">Returns the keys from the details</p>
    "!
    "! @parameter r_val | <p class="shorttext synchronized" lang="EN">Keys</p>
    methods key_tab
              returning
                value(r_val) type zcl_gw_request=>t_key_tab.

    "! <p class="shorttext synchronized" lang="EN">Returns the keys that match the current entity</p>
    "!
    "! @parameter i_mappings | <p class="shorttext synchronized" lang="EN">Mapping for the names of the keys</p>
    "! @parameter r_val | <p class="shorttext synchronized" lang="EN">Current entity keys</p>
    "! @raising /iwbep/cx_mgw_med_exception | <p class="shorttext synchronized" lang="EN">Meta data exception</p>
    methods matching_key_tab
              importing
                i_mappings type ref to zcl_gw_name_values optional
              returning
                value(r_val) type zcl_gw_request=>t_key_tab
              raising
                /iwbep/cx_mgw_med_exception.

    "! <p class="shorttext synchronized" lang="EN">Returns an SQL where clause based on the $filter query</p>
    "!
    "! @parameter r_val | <p class="shorttext synchronized" lang="EN">Filter query as SQL where</p>
    "! @raising /iwbep/cx_mgw_busi_exception | <p class="shorttext synchronized" lang="EN">Business Exception</p>
    methods filter_as_sql_where
              returning
                value(r_val) type string
              raising
                /iwbep/cx_mgw_busi_exception.

    "! <p class="shorttext synchronized" lang="EN">Returns an SQL where clause based on the $filter or the keys</p>
    "!
    "! @parameter i_mappings | <p class="shorttext synchronized" lang="EN">Mapping for the names of the keys</p>
    "! @parameter r_val | <p class="shorttext synchronized" lang="EN">Access conditions as SQL where</p>
    "! @raising /iwbep/cx_mgw_med_exception | <p class="shorttext synchronized" lang="EN">Meta data exception</p>
    "! @raising /iwbep/cx_mgw_busi_exception | <p class="shorttext synchronized" lang="EN">Business Exception</p>
    methods sql_where
              importing
                i_mappings type ref to zcl_gw_name_values optional
              returning
                value(r_val) type string
              raising
                /iwbep/cx_mgw_med_exception
                /iwbep/cx_mgw_busi_exception.

    "! <p class="shorttext synchronized" lang="EN">Returns the $select query as an SQL clause</p>
    "!
    "! @parameter r_val | <p class="shorttext synchronized" lang="EN">Select query as SQL fields</p>
    methods sql_fields
              returning
                value(r_val) type string.

    "! <p class="shorttext synchronized" lang="EN">Returns only the target fields as an SQL clause</p>
    "!
    "! @parameter r_val | <p class="shorttext synchronized" lang="EN">Fields after '/'</p>
    methods navigation_target_sql_fields
              returning
                value(r_val) type string.

    "! <p class="shorttext synchronized" lang="EN">Returns only the source fields as an SQL clause</p>
    "!
    "! @parameter r_val | <p class="shorttext synchronized" lang="EN">Fields before '/'</p>
    methods navigation_source_sql_fields
              returning
                value(r_val) type string.

    "! <p class="shorttext synchronized" lang="EN">Throws exception if the request contains an invalid option</p>
    "! <strong>WIP</strong>: don't use
    "!
    "! @parameter i_methods | <p class="shorttext synchronized" lang="EN">Methods that shouldn't be used</p>
    "! @parameter r_val | <p class="shorttext synchronized" lang="EN">Self</p>
    "! @raising /iwbep/cx_mgw_busi_exception | <p class="shorttext synchronized" lang="EN">Business Exception</p>
    methods throw_error_when_used
              importing
                i_methods type string_sorted_table
              returning
                value(r_val) type ref to zcl_gw_request
              raising
                /iwbep/cx_mgw_busi_exception.

    "! <p class="shorttext synchronized" lang="EN">Returns the key properties of the current entity</p>
    "!
    "! @parameter r_val | <p class="shorttext synchronized" lang="EN">Properties flagged as key</p>
    "! @raising /iwbep/cx_mgw_med_exception | <p class="shorttext synchronized" lang="EN">Meta </p>
    methods current_entity_keys
              returning
                value(r_val) type zcl_gw_request=>t_entity_keys
              raising
                /iwbep/cx_mgw_med_exception.

    methods mapped_with_current_key_values
              importing
                value(i_data) type any
              returning
                value(r_val) type ref to data
              raising
                /iwbep/cx_mgw_tech_exception.

  protected section.

    data an_original_request type zcl_gw_request=>t_original_request.

    data a_lazy_detail_str type zcl_gw_request=>t_details.

    data a_lazy_tech_detail_str type zcl_gw_request=>t_tech_details.

endclass.
class zcl_gw_request implementation.

  method constructor.

    me->an_original_request = i_original_request.

  endmethod.
  method details.

    if me->a_lazy_detail_str is initial.

      me->a_lazy_detail_str = me->original( )->get_request_details( ).

    endif.

    r_val = me->a_lazy_detail_str.

  endmethod.
  method tech_details.

    if me->a_lazy_detail_str is initial.

      me->a_lazy_tech_detail_str = me->details( )-technical_request.

    endif.

    r_val = me->a_lazy_tech_detail_str.

  endmethod.
  method model.

    cast /iwbep/if_mgw_req_key_convert( me->tech_details( )-key_converter )->get_entity_type( )->get_model( importing eo_model = r_val ).

  endmethod.
  method original.

    r_val = me->an_original_request.

  endmethod.
  method current_entity_name.

    r_val = me->tech_details( )-target_entity_set.

  endmethod.
  method current_entity_type.

    r_val = cast #( cast /iwbep/if_mgw_odata_fw_model( me->model( ) )->get_entity_type_by_set_name( conv #( me->current_entity_name( ) ) ) ).

  endmethod.
  method key_tab.

    r_val = corresponding #( me->details( )-key_tab ).

  endmethod.
  method matching_key_tab.

    types properties type sorted table of /iwbep/if_mgw_odata_fw_prop=>ty_s_mgw_odata_property with unique key name.

    data(current_entity_properties) = conv properties( cast /iwbep/if_mgw_odata_fw_etype( me->current_entity_type( ) )->get_properties( ) ).

    data(mapped_keys) = value me->t_key_tab( let mapping_data = cond #( when i_mappings is bound
                                                                        then i_mappings->data( ) ) in
                                             for <key> in me->key_tab( )
                                             ( value #( base <key>
                                                        name = value #( mapping_data[ name = <key>-name ]-value default <key>-name ) ) ) ).

    r_val = filter #( mapped_keys in current_entity_properties where name eq name ).

  endmethod.
  method filter_as_sql_where.

    r_val = cast /iwbep/if_mgw_req_entityset( me->original( ) )->get_osql_where_clause( ).

  endmethod.
  method sql_where.

    data(filter_where) = me->filter_as_sql_where( ).

    r_val = cond #( when filter_where is not initial
                    then filter_where
                    else cond #( let keys = new zcl_gw_request( me->original( ) )->matching_key_tab( i_mappings ) in
                                 when keys is not initial
                                 then new zcl_gw_name_values( corresponding #( keys ) )->as_sql_where( ) ) ).

  endmethod.
  method sql_fields.

    r_val = cond #( when me->tech_details( )-navigation_path is initial
                    then me->navigation_source_sql_fields( )
                    else concat_lines_of( table = cast /iwbep/if_mgw_req_entityset( me->original( ) )->get_select_with_mandtry_fields( )
                                          sep = `, ` ) ).

  endmethod.
  method throw_error_when_used.
"TODO: obtain all methods of class /iwbep/cl_mgw_request (in the provided i tab)
"TODO: obtain returning parameters of each method
"TODO: create type dynamically
"TODO: create ref of dyn type
"TODO: call method with returning parameter name and valid reference with correct type
"TODO: create subexception of zcx_static_check with exception table containing all errors at once, and use that one as previous
    data val type ref to data.

*    create data val type handle x.

    data(original) = me->original( ).

    data(tab) = value abap_parmbind_tab( ( name = 'RV_OSQL_WHERE_CLAUSE'
                                           kind = cl_abap_objectdescr=>returning
                                           value = val ) ).

    data(test) = '/IWBEP/IF_MGW_REQ_ENTITYSET~GET_OSQL_WHERE_CLAUSE'.

    try.

      call method original->(test)
        parameter-table tab.

      if tab[ name = 'RV_OSQL_WHERE_CLAUSE' ]-value is not initial.

*        raise exception type /iwbep/cx_mgw_busi_exception exporting entity_type = me->current_entity_type( )->/iwbep/if_mgw_odata_fw_etype~get_name( )
*                                                                    message_unlimited = `Query option not implemented`.

      endif.

    catch cx_sy_dyn_call_error.

    endtry.

  endmethod.
  method current_entity_keys.

    r_val = value #( for <prop> in me->model( )->get_properties_of_entity( me->current_entity_type( )->get_id( ) )
                     where ( is_key = abap_true )
                     ( <prop> ) ).

  endmethod.
  method navigation_target_sql_fields.

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
  method navigation_source_sql_fields.

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
  method mapped_with_current_key_values.

    data(key_properties) = me->current_entity_keys( ).

    data(key_values) = me->key_tab( ).

    loop at key_properties reference into data(property).

      assign component property->*-external_name of structure i_data to field-symbol(<value>).

      <value> = key_values[ name = property->*-external_name ]-value.

    endloop.

    r_val = new zcl_data_object_copy( i_data )->ref( ).

  endmethod.

endclass.
