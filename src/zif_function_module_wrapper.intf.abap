interface ZIF_FUNCTION_MODULE_WRAPPER
  public .


  methods THROW_EXCEPTION_ON_ERROR_FROM default ignore
    importing
      !ID_FUNCTION_MODULE type RS38L_FNAM .
  methods REMOVE_EXISTING_MESSAGES default ignore .
  methods STORE_EXCEPTION_DETAILS_FROM default ignore
    importing
      !ID_FUNCTION_MODULE type RS38L_FNAM .
endinterface.
