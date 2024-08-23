"! <p class="shorttext synchronized" lang="EN">Adapter for {@link /IWBEP/CX_MGW_TECH_EXCEPTION}</p>
class zcx_gw_server definition
                    public
                    create public
                    inheriting from /iwbep/cx_mgw_tech_exception.

  public section.

    constants: "! A generic error message, given when no more specific message is suitable
               internal_server_error type /iwbep/mgw_http_status_code value '500',
               "! The server either does not recognise the request method, or it lacks the ability to fulfill the request
               not_implemented type /iwbep/mgw_http_status_code value '501',
               "! The server is currently unavailable (because it is overloaded or down for maintenance)
               service_unavailable type /iwbep/mgw_http_status_code value '503'.

    "! <p class="shorttext synchronized" lang="EN">Creates an exception. Can use a t100 msg</p>
    "!
    "! @parameter i_http_response_status | <p class="shorttext synchronized" lang="EN">Response Status code</p>
    "! @parameter i_t100_message | <p class="shorttext synchronized" lang="EN">t100 message</p>
    "! @parameter i_previous | <p class="shorttext synchronized" lang="EN"></p>
    methods constructor
              importing
                i_http_response_status type /iwbep/mgw_http_status_code
                i_t100_message type ref to if_t100_message optional
                i_previous like previous optional.

    data var1 type sy-msgv1 read-only.

    data var2 type sy-msgv2 read-only.

    data var3 type sy-msgv4 read-only.

    data var4 type sy-msgv4 read-only.

endclass.
class zcx_gw_server implementation.

  method constructor ##ADT_SUPPRESS_GENERATION.

    super->constructor( previous = i_previous ).

    me->textid = value #( ).

    if i_http_response_status between 500 and 599.

      me->http_status_code = i_http_response_status.

      if i_t100_message is supplied.

        cl_message_helper=>set_msg_vars_for_if_t100_msg( i_t100_message ).

        me->var1 = sy-msgv1.

        me->var2 = sy-msgv2.

        me->var3 = sy-msgv3.

        me->var4 = sy-msgv4.

        me->if_t100_message~t100key = value #( msgid = sy-msgid
                                               msgno = sy-msgno
                                               attr1 = 'VAR1'
                                               attr2 = 'VAR2'
                                               attr3 = 'VAR3'
                                               attr4 = 'VAR4' ).

      else.

        me->if_t100_message~t100key = if_t100_message=>default_textid.

      endif.

    else.

      raise exception type zcx_no_check.

    endif.

  endmethod.

endclass.
