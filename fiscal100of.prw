#include "protheus.ch"
#include "totvs.ch"

//---------------------------------------------------------//
// Browser com Uso das Listas para cadastro 				   //
//---------------------------------------------------------//
User Function xCadastra()

 
Local aList := {}
Local dValida := Ctod("31/12/17") 


If dValida < Date()
			MsgInfo("Prazo de utiliza��o foi expirado, entre em contato com o respons�vel sobre a Ferramenta"+" "+" \('-')/","Aten��o")	
Else
    DEFINE DIALOG oDlg TITLE "Automatizador de Cadastros 2.0" FROM 180,180 TO 550,700 PIXEL
 
       /* Vetor com elementos do Browse*/
       
        aBrowse := { {'#001','Reten��o ISS'},;
        				{'#002','Reten��o INSS'},;
        				{'#003','Reten��o PCC'},;
        				{'#004','Reten��o SENAR'},;
        				{'#005','Reten��o IRRF'},;
        				{'#006','C�lculo ICMS/DIFAL'},;
        				{'#007','C�lculo ICMS ST'},;
        				{'#008','Calculo ICMS/IPI'},;
        				{'#009','Nota de Importa��o'},;
        				{'#010','CIAP'},;
        				{'#011','FETHAB/FACS'}}
        				
        				
       
 
        // Cria Browse
        oBrowse := TCBrowse():New( 01 , 01, 260, 156,, {'Codigo','Descri��o'},{20,50,50,50}, oDlg,,,,,{||},,,,,,,.F.,,.T.,,.F.,,, )
 
        // Seta vetor para a browse
        oBrowse:SetArray(aBrowse)
 
        // Monta a linha a ser exibida no Browse
        oBrowse:bLine := {||{  aBrowse[oBrowse:nAt,01],aBrowse[oBrowse:nAt,02] } }
  
        // Evento de duplo click na celula
        oBrowse:bLDblClick := {|| listcase() }
       
 
        // Cria Botoes com metodos b�sicos
         
       TButton():New( 165, 003, "Documento de Entrada", oDlg,{|| MATA103(), oBrowse:setFocus() },80,010,,,.F.,.T.,.F.,,.F.,,,.F. )
       TButton():New( 165, 086, "Pedido de Venda" , oDlg,{|| MATA410(), oBrowse:setFocus() },80,010,,,.F.,.T.,.F.,,.F.,,,.F. )
       TButton():New( 165, 168, "Cadastrar Todos" , oDlg,{|| u_todos(), oBrowse:setFocus() },80,010,,,.F.,.T.,.F.,,.F.,,,.F. )
         
         		 			
    ACTIVATE DIALOG oDlg CENTERED
    
EndIf
RETURN

Static function listcase 

nLinha := oBrowse:nat   
    
    //Valida a op��o do usu�rio para executar a fun��o configurada no fonte FISCALX
DO Case 
	Case nLinha == 1 
			
		u_zCalcRetIss()
			
	Case nLinha == 2		
		u_zCalcInss()
	Case nLinha == 3	 
		u_RetPCC()
	Case nLinha == 4
		u_zSenar()
	Case nLinha == 5
		u_zirrf()
	Case nLinha == 6
		u_zCalcIcms()
	Case nLinha == 7
		u_zCalcST()
	Case nLinha == 8
		u_zFisIcmIp()
	Case nLinha == 9
		u_zImportacao()
	Case nLinha == 10
		u_CalcCiap()	
	Case nLinha == 11
		u_facfamad()	
	
EndCase
 
Return

