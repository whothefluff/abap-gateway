
# abap-gateway

The gateway library hides information unnecessarily and in a weird convoluted way that makes it harder to use for some incomprehensible reason.

## Some uses

```abap
data(request) = new zcl_gw_request( io_tech_request_context ).
```


1. Generate SQL WHERE condition string (basically for $filter operation, although it also supports a search with the full ID):
   ```abap
   data(sql_where_string) = request->sql_where( ).
   ```

2. Generate SQL fields string (handles $select query option for you, for free):
   ```abap
   data(sql_fields_string) = request->sql_fields( ).
   ```

3. Get the OData model (why shouldn't you able to in the first place smh):
   ```abap
   data(odata_model) = request->model( ).
   ```

4. Access the full original request (tis but a wrapper, this object of mine):
   ```abap
   data(full_request) = request->original( ).
   ```
   
# dependencies:
  - [https://github.com/whothefluff/abap-messages](https://github.com/whothefluff/abap-messages)
  - [https://github.com/whothefluff/abap-messages](https://github.com/whothefluff/abap-name-values)
  - [https://github.com/whothefluff/abap-messages](https://github.com/whothefluff/abap-dataobject)
