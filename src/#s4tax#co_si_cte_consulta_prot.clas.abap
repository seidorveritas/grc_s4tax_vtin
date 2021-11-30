class /S4TAX/CO_SI_CTE_CONSULTA_PROT definition
  public
  inheriting from CL_PROXY_CLIENT
  create public .

public section.

  methods CONSTRUCTOR
    importing
      !LOGICAL_PORT_NAME type PRX_LOGICAL_PORT_NAME optional
    raising
      CX_AI_SYSTEM_FAULT .
  methods SI_CTE_CONSULTA_PROTOCOLO_SYNC
    importing
      !OUTPUT type /S4TAX/MT_CTE_CONSULTA_PROTOC1
    exporting
      !INPUT type /S4TAX/MT_CTE_CONSULTA_PROTOCO
    raising
      CX_AI_SYSTEM_FAULT
      CX_AI_APPLICATION_FAULT .
protected section.
private section.
ENDCLASS.



CLASS /S4TAX/CO_SI_CTE_CONSULTA_PROT IMPLEMENTATION.


method CONSTRUCTOR.

  super->constructor(
    class_name          = '/S4TAX/CO_SI_CTE_CONSULTA_PROT'
    logical_port_name   = logical_port_name
  ).

endmethod.


method SI_CTE_CONSULTA_PROTOCOLO_SYNC.

  data:
    ls_parmbind type abap_parmbind,
    lt_parmbind type abap_parmbind_tab.

  ls_parmbind-name = 'OUTPUT'.
  ls_parmbind-kind = cl_abap_objectdescr=>importing.
  get reference of OUTPUT into ls_parmbind-value.
  insert ls_parmbind into table lt_parmbind.

  ls_parmbind-name = 'INPUT'.
  ls_parmbind-kind = cl_abap_objectdescr=>exporting.
  get reference of INPUT into ls_parmbind-value.
  insert ls_parmbind into table lt_parmbind.

  if_proxy_client~execute(
    exporting
      method_name = 'SI_CTE_CONSULTA_PROTOCOLO_SYNC'
    changing
      parmbind_tab = lt_parmbind
  ).

endmethod.
ENDCLASS.
