"! <p class="shorttext synchronized" lang="EN">Adapter for {@link /IWBEP/CX_MGW_BUSI_EXCEPTION}</p>
class zcx_gw_client definition
                    public
                    create public
                    inheriting from /iwbep/cx_mgw_busi_exception.

  public section.

    constants:
               "! <p class="shorttext synchronized" lang="EN">The request cannot be fulfilled due to bad syntax</p>
               bad_request type /iwbep/mgw_http_status_code value '400',
               "! <p class="shorttext synchronized" lang="EN">The request was legal, but the server refuses to respond</p>
               forbidden type /iwbep/mgw_http_status_code value '403',
               "! <p class="shorttext synchronized" lang="EN">The requested resource could not be found</p>
               "! It may be available in the future
               not_found type /iwbep/mgw_http_status_code value '404',
               "! <p class="shorttext synchronized" lang="EN">A request of a resource used a not supported request method</p>
               method_not_allowed type /iwbep/mgw_http_status_code value '405',
               "! <p class="shorttext synchronized" lang="EN">The requested resource can't generate acceptable content</p>
               "! According to the Accept headers sent in the request
               not_acceptable type /iwbep/mgw_http_status_code value '406',
               "! <p class="shorttext synchronized" lang="EN">The request could not be processed because of conflict</p>
               "! Such as an edit conflict
               conflict type /iwbep/mgw_http_status_code value '409',
               "! <p class="shorttext synchronized" lang="EN">A resource existed earlier but is not available anymore</p>
               gone type /iwbep/mgw_http_status_code value '410',
               "! <p class="shorttext synchronized" lang="EN">The server does not meet the requester's preconditions</p>
               precondition_failure type /iwbep/mgw_http_status_code value '412',
               "! <p class="shorttext synchronized" lang="EN">Media type of the request unsupported by the server/resource</p>
               unsupported_media_type type /iwbep/mgw_http_status_code value '415',
               "! <p class="shorttext synchronized" lang="EN">The server requires the request to be conditional (RFC 6585)</p>
               precondition_requirement type /iwbep/mgw_http_status_code value '428'.

    "! <p class="shorttext synchronized" lang="EN">Creates an exception. Can use a t100 message</p>
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

  protected section.

endclass.
class zcx_gw_client implementation.

  method constructor ##ADT_SUPPRESS_GENERATION.

    super->constructor( previous = i_previous ).

    me->textid = value #( ).

    if i_http_response_status between 400 and 499.

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
