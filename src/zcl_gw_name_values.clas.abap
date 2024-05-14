"! <p class="shorttext synchronized" lang="EN">Gateway Name Value Pairs</p>
class zcl_gw_name_values definition
                         public
                         create public.

  public section.

    types t_data type /iwbep/t_mgw_name_value_pair.

    "! <p class="shorttext synchronized" lang="EN">Creates a new pair list</p>
    "!
    "! @parameter i_data | <p class="shorttext synchronized" lang="EN">Data</p>
    methods constructor
              importing
                i_data type zcl_gw_name_values=>t_data.

    "! <p class="shorttext synchronized" lang="EN">Returns the data as is</p>
    "!
    "! @parameter r_val | <p class="shorttext synchronized" lang="EN">Raw data</p>
    methods data
              returning
                value(r_val) type zcl_gw_name_values=>t_data.

    "! <p class="shorttext synchronized" lang="EN">Returns a select-options based on equalities</p>
    "!
    "! @parameter r_val | <p class="shorttext synchronized" lang="EN">Select-options</p>
    methods as_select_options
              returning
                value(r_val) type rsds_frange_t.

    "! <p class="shorttext synchronized" lang="EN">Returns an SQL where clause based on equalities</p>
    "!
    "! @parameter r_val | <p class="shorttext synchronized" lang="EN">SQL where</p>
    methods as_sql_where
              returning
                value(r_val) type string.

  protected section.

    data a_data_tab type zcl_gw_name_values=>t_data.

endclass.
class zcl_gw_name_values implementation.

  method constructor.

    me->a_data_tab = i_data.

  endmethod.
  method data.

    r_val = me->a_data_tab.

  endmethod.
  method as_select_options.

    r_val = value #( let aux = me->data( ) in
                     for groups of <by_name> in aux group by <by_name>-name
                     ( fieldname = <by_name>-name
                       selopt_t = value #( for <segment> in group <by_name>
                                           sign = 'I'
                                           option = 'EQ'
                                           ( low = <segment>-value ) ) ) ).

  endmethod.
  method as_sql_where.

    data(ranges) = value rsds_trange( ( tablename = value #( )
                                        frange_t = me->as_select_options( ) ) ).

    data(where) = value rsds_twhere( ).

    call function 'FREE_SELECTIONS_RANGE_2_WHERE'
      exporting
        field_ranges  = ranges
      importing
        where_clauses = where.

    r_val = condense( concat_lines_of( table = where[ 1 ]-where_tab
                                       sep = ` ` ) ).

  endmethod.

endclass.
