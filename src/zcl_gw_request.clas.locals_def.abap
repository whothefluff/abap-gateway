*"* use this source file for any type of declarations (class
*"* definitions, interfaces or type declarations) you need for
*"* components in the private section
class forbidden_methods definition "#EC CLAS_FINAL
                        create public
                        inheriting from zcx_gw_server.

  public section.

    types: begin of t_entry,
             name type abap_methname,
             ref type ref to zcx_gw_server,
           end of t_entry,
           t_list type sorted table of t_entry with unique key name.

    methods constructor
              importing
                i_list type forbidden_methods=>t_list.

    methods list
              returning
                value(r_val) type forbidden_methods=>t_list.

  protected section.

    data a_list type forbidden_methods=>t_list.

endclass.
class request_types definition "#EC CLAS_FINAL
                    create public.

  public section.

    types: begin of t_entry,
             name type string,
             interface_name type abap_intfname,
           end of t_entry,
           t_data type sorted table of request_types=>t_entry with unique key name.

    constants: begin of create_entity,
                 name type request_types=>t_entry-name value `CreateEntity`,
                 interface_name type request_types=>t_entry-interface_name value '/IWBEP/IF_MGW_REQ_ENTITY_C',
               end of create_entity,
               begin of entity_set,
                 name type request_types=>t_entry-name value `EntitySet`,
                 interface_name type request_types=>t_entry-interface_name value '/IWBEP/IF_MGW_REQ_ENTITYSET',
               end of entity_set,
               begin of read_entity,
                 name type request_types=>t_entry-name value `ReadEntity`,
                 interface_name type request_types=>t_entry-interface_name value '/IWBEP/IF_MGW_REQ_ENTITY',
               end of read_entity,
               begin of update_entity,
                 name type request_types=>t_entry-name value `UpdateEntity`,
                 interface_name type request_types=>t_entry-interface_name value '/IWBEP/IF_MGW_REQ_ENTITY_U',
               end of update_entity,
               begin of patch_entity,
                 name type request_types=>t_entry-name value `PatchEntity`,
                 interface_name type request_types=>t_entry-interface_name value '/IWBEP/IF_MGW_REQ_ENTITY_P',
               end of patch_entity,
               begin of delete_entity,
                 name type request_types=>t_entry-name value `DeleteEntity`,
                 interface_name type request_types=>t_entry-interface_name value '/IWBEP/IF_MGW_REQ_ENTITY_D',
               end of delete_entity.

    class-methods class_constructor.

    methods intf_for
              importing
                i_name type request_types=>t_entry-name
              returning
                value(r_val) type request_types=>t_entry-interface_name.

  protected section.

    class-data a_list type request_types=>t_data.

endclass.
