# FunctionModuleWrapper
Short Text

Function Module Wrapper Interface + Abstract Superclass

Functionality

This class is intended to wrap function modules and dynamically read the "classic" exceptions and automatically turn them into class-based exceptions.
The idea is that you subclass this main class so that you inherit all the standard functionality and then add in anything extra you need.
· There is automatic recognition of whether the function module has filled the SY-MSGID variables while raising the classical exceptions (some do not, due to the doofus problem mentioned earlier).
· If there are classical exceptions, both the technical name (e.g. MONSTER_ONLY_ONE_INCH_TALL above) and any text description of the exception from the Transaction SE37 definition are captured automatically.
· You avoid the long string of possible exceptions in the calling code.
· While debugging, it’s still possible to tell exactly where the exception was raised.
· You can replace the call to the function module with a test double during unit tests.
· You can use inline declarations when getting the return parameters.
· You can change the chaotic SAP naming conventions for function modules to use a more logical name for your wrapper class—and possibly not name the parameters after German abbreviations (unless you’ve just come to love them after all this time).
· You have better syntax checking: a function module doesn’t complain when you pass in the wrong variable type, but a method does.
· Sometimes you can simplify the interface (signature) for function modules that have half a million parameters, most of which never get used.

Example

  METHOD golf_handicap_of_monster.

    remove_existing_messages( ).

    CALL FUNCTION 'ZMONSTER_GOLF_SCORES'
      EXPORTING
         id_monster_number             = id_monster_number
      IMPORTING
         ed_golf_handicap              = result
       EXCEPTIONS
        monster_only_one_inch_tall    = 1
        monster_has_no_silly_trousers = 2
        OTHERS                         = 3.

    IF sy-subrc <> 0.
       TRY.
          throw_exception_on_error_from( 'ZMONSTER_GOLF_SCORES' ).
        CATCH zcx_function_module_error INTO    DATA(function_module_error).
          "Need to raise the excetion here in the calling code in order to get
          "the call stack correct
          RAISE EXCEPTION function_module_error.
      ENDTRY.
    ENDIF.
    
Further information

Please read the blog 
https://blogs.sap.com/2016/10/29/harlem-function-module-shuffle/
