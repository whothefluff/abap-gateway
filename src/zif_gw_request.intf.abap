"! <p class="shorttext synchronized" lang="EN">Full Access Wrapper of a Gateway Request</p>
interface zif_gw_request public.

  types t_original_request type ref to /iwbep/cl_mgw_request.

  types t_details type /iwbep/if_mgw_core_srv_runtime=>ty_s_mgw_request_context.

  types t_tech_details type zif_gw_request=>t_details-technical_request.

  types t_model type ref to /iwbep/cl_mgw_odata_model.

  types t_entity_type type ref to /iwbep/cl_mgw_odata_entity_typ.

  types t_entity_keys type /iwbep/if_mgw_med_odata_types=>ty_t_med_properties.

  types: begin of t_key_entry,
           name type /iwbep/med_external_name,
           value type string,
         end of t_key_entry,
         t_key_tab type sorted table of zif_gw_request=>t_key_entry with unique key name.

  types t_forbidden_method_names type sorted table of abap_methname with unique key table_line.

  "! <p class="shorttext synchronized" lang="EN">Returns the standard request</p>
  "!
  "! @parameter r_val | <p class="shorttext synchronized" lang="EN">Wrapped request</p>
  methods original
            returning
              value(r_val) type zif_gw_request=>t_original_request.

  "! <p class="shorttext synchronized" lang="EN">Returns the data of the request</p>
  "!
  "! @parameter r_val | <p class="shorttext synchronized" lang="EN">Request data</p>
  methods details
            returning
              value(r_val) type zif_gw_request=>t_details.

  "! <p class="shorttext synchronized" lang="EN">Returns the technical data of the request</p>
  "!
  "! @parameter r_val | <p class="shorttext synchronized" lang="EN">Technical data</p>
  methods tech_details
            returning
              value(r_val) type zif_gw_request=>t_tech_details.

  "! <p class="shorttext synchronized" lang="EN">Returns the model associated with the request</p>
  "!
  "! @parameter r_val | <p class="shorttext synchronized" lang="EN">Model</p>
  methods model
              returning
                value(r_val) type zif_gw_request=>t_model.

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
                value(r_val) type zif_gw_request=>t_entity_type
              raising
                 /iwbep/cx_mgw_med_exception.

    "! <p class="shorttext synchronized" lang="EN">Returns the keys from the details</p>
    "!
    "! @parameter r_val | <p class="shorttext synchronized" lang="EN">Keys</p>
    methods key_tab
              returning
                value(r_val) type zif_gw_request=>t_key_tab.

    "! <p class="shorttext synchronized" lang="EN">Returns the keys that match the current entity</p>
    "!
    "! @parameter i_mappings | <p class="shorttext synchronized" lang="EN">Mapping for the names of the keys</p>
    "! @parameter r_val | <p class="shorttext synchronized" lang="EN">Current entity keys</p>
    "! @raising /iwbep/cx_mgw_med_exception | <p class="shorttext synchronized" lang="EN">Meta data exception</p>
    methods matching_key_tab
              importing
                i_mappings type ref to zcl_name_value_pairs optional
              returning
                value(r_val) type zif_gw_request=>t_key_tab
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
                i_mappings type ref to zcl_name_value_pairs optional
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
    "! If there is navigation the source fields are the fields before the '/' characters
    "! If there is no navigation then the source fields are the simple field list with no post-processing
    "!
    "! @parameter r_val | <p class="shorttext synchronized" lang="EN">Fields before '/'</p>
    methods navig_aware_source_sql_fields
              returning
                value(r_val) type string.

    "! <p class="shorttext synchronized" lang="EN">Throws exception if the request contains an invalid option</p>
    "! <strong>Only</strong> use methods with no mandatory importing parameters and a returning parameter.
    "! Otherwise it will fail
    "!
    "! @parameter i_methods | <p class="shorttext synchronized" lang="EN">Methods that shouldn't be used</p>
    "! @parameter r_val | <p class="shorttext synchronized" lang="EN">Self</p>
    "! @raising /iwbep/cx_mgw_busi_exception | <p class="shorttext synchronized" lang="EN">Business Exception</p>
    methods throw_error_when_used
              importing
                i_methods type zif_gw_request=>t_forbidden_method_names
                i_request_type type string
              returning
                value(r_val) type ref to zif_gw_request
              raising
                /iwbep/cx_mgw_busi_exception
                /iwbep/cx_mgw_tech_exception.

    "! <p class="shorttext synchronized" lang="EN">Returns the key properties of the current entity</p>
    "!
    "! @parameter r_val | <p class="shorttext synchronized" lang="EN">Properties flagged as key</p>
    "! @raising /iwbep/cx_mgw_med_exception | <p class="shorttext synchronized" lang="EN">Meta </p>
    methods current_entity_keys
              returning
                value(r_val) type zif_gw_request=>t_entity_keys
              raising
                /iwbep/cx_mgw_med_exception.

    "! <p class="shorttext synchronized" lang="EN">Returns a structure reference with the key values assigned</p>
    "! It takes a structure of the same type that will be returned in the reference.
    "! It's mostly helpful for operations that use the entity key such as UPDATE, DELETE, etc.
    "! Since it will return the structure reference with all its key fields filled
    "!
    "! @parameter i_data | <p class="shorttext synchronized" lang="EN"></p>
    "! @parameter r_val | <p class="shorttext synchronized" lang="EN"></p>
    "! @raising /iwbep/cx_mgw_tech_exception | <p class="shorttext synchronized" lang="EN"></p>
    methods mapped_with_current_key_values
              importing
                value(i_data) type any
              returning
                value(r_val) type ref to data
              raising
                /iwbep/cx_mgw_tech_exception.

endinterface.
