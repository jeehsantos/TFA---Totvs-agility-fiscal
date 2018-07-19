//Bibliotecas
#Include "Protheus.ch"
#INCLUDE "rwmake.ch"
#include "topconn.ch"   
#include "TOTVS.CH"
#include "tbiconn.ch"
  
#Define STR_PULA   Chr(13)+Chr(10)
#Define cBarra	     "------------------------------------------------------------------------------------------"			
/* 
						#001 Retenção ISS  - OK
        				#002 Retenção INSS - OK
        				#003 Retenção PCC  - Ok
        				#004 Retenção SENAR/FUNRURAL  Ok
        				#005 Retenção IRRF  - ok
        				#006 Cálculo ICMS/DIFAL - ok
        				#007 Cálculo ICMS ST - OK
        				#008 Calculo ICMS/IPI - OK
        				#009 Nota de Importação - Validar
        				#010 CIAP - ok
*/

/*---------------------------------------------------------------------------------*
 | Func.:                                                                          |
 | Autor:                                                                          |
 | Data:                                                                           |
 | Desc:                                                                           |
 *---------------------------------------------------------------------------------*/
 
  //#002 - Cálculo de Inss
User Function zCalcInss()

Local aArea     := GetArea()
Local aCont	  := {}
Local cMensagem := " " 
Local cArq		  := "C:\tmp\log_inclusao.txt"
Local lValid    := .T.
Local nLinha    := 0


If MsgYesNo("Deseja incluir os cadastros para cálculo de INSS ?","Atenção !") 
     
     DbSelectArea("SA1")
     SA1->(DbSetOrder(1))
     SA1->(DbGoTop())


		If dbSeek(xFilial("SA1")+ "900000" + "01")  // Se achou retorna F pois não pode dar chave duplicada
		 	
			//AADD(aCont, cMensagem += "- Cliente:"+" "+ Alltrim(A1_COD)+STR_PULA) 
		   // FWrite(nHandle, "Cliente já cadastrado ! "+ STR_PULA + cBarra+STR_PULA+"Código: 900000"+STR_PULA)
			cMensagem+= "Cliente:"+ STR_PULA+"Código: 900000"+STR_PULA+"Nome:PJ INSS - MG"+STR_PULA
			lValid 	:= .F.
		Else

		  RecLock('SA1', .T.)
		 	aCont:= {}
			AADD(aCont,{"Filial:	",SA1->A1_FILIAL := FwxFilial('SA1')})
			AADD(aCont,{"Codigo:	",SA1->A1_COD		:= "900000"})
			AADD(aCont,{"Loja:	",SA1->A1_LOJA	:= "01"})
			AADD(aCont,{"Tipo Pessoa:"	,SA1->A1_PESSOA	:= "J"})
			AADD(aCont,{"Nome:	",SA1->A1_NOME 	:= "PJ INSS - MG"})
			AADD(aCont,{"Apelido:	",SA1->A1_NREDUZ	:= "PJ INSS - MG"})
			AADD(aCont,{"Endereço:"	,SA1->A1_END		:= "Rua. Braz Leme"})
			AADD(aCont,{"Tipo:	",SA1->A1_TIPO	:= "F"})
			AADD(aCont,{"Estado:	",SA1->A1_EST		:= "MG"})
			AADD(aCont,{"Cód Município:	",SA1->A1_COD_MUN := "00203"})
			AADD(aCont,{"Município:	",SA1->A1_MUN		:= "ABAETE"})
			AADD(aCont,{"Recolhe INSS:	",SA1->A1_RECINSS := "N"})
			AADD(aCont,{"Natureza:	",SA1->A1_NATUREZ := "9999999999"})
			AADD(aCont,{"CNPJ:	",SA1->A1_CGC 	 := "13244147000179"})
			
			SA1->(MsUnlock())
		    	//FWrite(nHandle, "Cliente: "+ STR_PULA + cBarra+STR_PULA)
		    	cMensagem+="Cliente: "+ STR_PULA + cBarra+STR_PULA
		    	For nLinha := 1 to len(aCont)
		    	 
		   
		    	//FWrite(nHandle,aCont[nLinha][1]+ cValToChar(ALLTRIM(aCont[nLinha][2]))+STR_PULA)
				cMensagem+= aCont[nLinha][1]+ cValToChar(ALLTRIM(aCont[nLinha][2]))+STR_PULA
				Next nLinha
				
		    				
		Endif

    //Cadastro de Fornecedor
    
     DbSelectArea("SA2")
     SA2->(DbSetOrder(1))
     SA2->(DbGoTop())
  
	If dbSeek(xFilial("SA2")+ "999999" + "01")  // Se achou retorna F pois não pode dar chave duplicada
		 
		 //AADD(aCont, cMensagem += "- Fornecedor:"+" "+ Alltrim(A2_COD)+STR_PULA) 
		 //FWrite(nHandle, cBarra+STR_PULA+"Fornecedor já cadastrado ! "+ STR_PULA + cBarra+STR_PULA+"Código: 999999"+STR_PULA)
     	 	cMensagem+= STR_PULA+"Fornecedor:"+STR_PULA +"Código: 999999"+STR_PULA+"Nome: PJ INSS - MG"+STR_PULA
     	 	lValid 	:= .F.
    Else
    	 
		RecLock('SA2', .T.)
		 	aCont:= {}
			AADD(aCont,{"Filial: ", A2_FILIAL := FwxFilial('SA2')})
			AADD(aCont,{"Código: ",A2_COD		:= "999999"})
			AADD(aCont,{"Nome: ", A2_NOME	:= "PJ INSS - MG"})
			AADD(aCont,{"Apelido: ",A2_NREDUZ	:= "PJ INSS - MG"})
			AADD(aCont,{"Loja: ", A2_LOJA 	:= "01"})
			AADD(aCont,{"Endereço: ",A2_END 	:= "Av. Braz Leme"})
			AADD(aCont,{"Estado: ", A2_EST		:= "MG"})
			AADD(aCont,{"Cód Município: ",A2_COD_MUN	:= "00203"})
			AADD(aCont,{"Município: ", A2_MUN		:= "ABAETE"})
			AADD(aCont,{"Tipo Fornecedor: ",A2_TIPO	:= "J"})
			AADD(aCont,{"CNPJ: ", A2_CGC 	:= "35683726000150"})
			AADD(aCont,{"Recolhe INSS: ", A2_RECINSS	:= "S"})
			
			SA2->(MsUnlock())
			 
      		//FWrite(nHandle,cBarra+STR_PULA+ "Fornecedor: "+ STR_PULA + cBarra+STR_PULA) 
      	cMensagem+=cBarra+STR_PULA+ "Fornecedor: "+ STR_PULA + cBarra+STR_PULA
      		For nLinha := 1 to len(aCont)
		    	 
		   
		    	//FWrite(nHandle,aCont[nLinha][1]+ cValToChar(aCont[nLinha][2])+STR_PULA)
				cMensagem+= aCont[nLinha][1]+ cValToChar(aCont[nLinha][2])+STR_PULA
				Next nLinha
      		 
    EndIf
    
     
    //Cadastro de Natureza
    
    DbSelectArea("SED")
     SED->(DbSetOrder(1))
     SED->(DbGoTop())

    If DbSeek(xFilial("SED")+ "9999999999")
   			 
		   //FWrite(nHandle, cBarra+STR_PULA+"Natureza já cadastrada ! "+ STR_PULA + cBarra+STR_PULA+"Código: 9999999999"+STR_PULA)
     	 cMensagem+=STR_PULA+"Natureza:"+STR_PULA+"Código: 9999999999"+STR_PULA+"Descrição: Retenção INSS"+STR_PULA
     	 lValid 	:= .F.
    Else
     	
	 
    RecLock('SED', .T.)
    
		aCont:= {}
		
		AADD(aCont,{"Filial: ", ED_FILIAL := FwxFilial('SED')})
    	AADD(aCont,{"Código: ", ED_CODIGO	:= "9999999999"})
    	AADD(aCont,{"Descrição: ", ED_DESCRIC	:= "Retenção INSS"})
    	AADD(aCont,{"Calcula INSS: ", ED_CALCINS	:= "S"})
    	AADD(aCont,{"Percentual INSS:", ED_PERCINS	:= 11.00})
    	AADD(aCont,{"Cond. Naturez:",ED_COND	:= "R"})
    	
    	SED->(MsUnlock())
  
  				//FWrite(nHandle,cBarra+STR_PULA+ "Natureza: "+ STR_PULA + cBarra+STR_PULA) 
		    	cMensagem+=cBarra+STR_PULA+ "Natureza: "+ STR_PULA + cBarra+STR_PULA
		    	For nLinha := 1 to len(aCont)
		    	 
		   
		    	//FWrite(nHandle,aCont[nLinha][1]+ cValToChar(aCont[nLinha][2])+STR_PULA)
				cMensagem+=aCont[nLinha][1]+ cValToChar(aCont[nLinha][2])+STR_PULA
				Next nLinha
					
		 
    EndIf
    			
    
   /* RestArea(aArea)*/
    
    	//Cadastro de produto
    	
     DbSelectArea("SB1")
     SB1->(DbSetOrder(1))
     SB1->(DbGoTop())
  
    

    If DbSeek(xFilial("SB1")+ "999999999999999")
     	 
		 	//FWrite(nHandle, cBarra+STR_PULA+"Produto já cadastrado ! "+ STR_PULA + cBarra+STR_PULA+"Código: 999999999999999"+STR_PULA)
     	 
     	  cMensagem+= STR_PULA+"Produto: "+STR_PULA+"Código: 999999999999999"+STR_PULA+"Descrição: Retenção INSS"+STR_PULA
     	  lValid 	:= .F.
     	 	
    Else
     	
  		  
		RecLock('SB1', .T.)
		   aCont:= {}
			AADD(aCont,{"Filial: ",B1_FILIAL := FwxFilial('SB1')})
			AADD(aCont,{"Código: ",B1_COD		:= "999999999999999"})
			AADD(aCont,{"Descrição:", B1_DESC	:= "Retenção INSS"})
			AADD(aCont,{"Tipo: ", B1_TIPO	:= "ME"})
			AADD(aCont,{"Unidade:", B1_UM		:= "UN"})
			AADD(aCont,{"Armazém: ", B1_LOCPAD	:= "01"})
			AADD(aCont,{"Origem:", B1_ORIGEM := "0"})
			AADD(aCont,{"Calcula INSS:", B1_INSS	:= "S"})
			AADD(aCont,{"Contr.Endere: ",B1_LOCALIZ := "N"})
			
			SB1->(MsUnlock())
  				//FWrite(nHandle,cBarra+STR_PULA+ "Produto: "+ STR_PULA + cBarra+STR_PULA) 
    		 cMensagem+=cBarra+STR_PULA+ "Produto: "+ STR_PULA + cBarra+STR_PULA
    		For nLinha := 1 to len(aCont)
		    	 
		   
		    	//FWrite(nHandle,aCont[nLinha][1]+ cValToChar(aCont[nLinha][2])+STR_PULA)
		    	cMensagem+= aCont[nLinha][1]+ cValToChar(aCont[nLinha][2])+STR_PULA
			Next nLinha
			 
    EndIf
     		MemoWrite( cArq, cMensagem )
		//FClose(nHandle)
		 		 
		 		If lValid 
		 		
		 		AVISO("Atenção | Log de inclusão ", cMensagem, { "Salvar", "OK" }, 03)
		 		Else				
		 		AVISO("Atenção | Este registro já foi cadastrado!", cMensagem, { "Salvar", "OK" }, 03)
		 		EndIf
 		MsgInfo("Sua nota para retenção de INSS já pode ser lançada !","Alerta !")
 	 	
     
	 //RestArea(aArea)
Else 
		MsgInfo("Operação abortada ! ","Atenção")
		
		 RestArea(aArea)
EndIf

Return

	
	 

	//#006 - Cálculo de Icms/DIFAL
User Function zCalcIcms()
  Local aArea    := GetArea()
  	Local aCont:= {}
 	Local cMensagem := " " 

 

	DbSelectArea("SA1")
	SA1->(DbSetOrder(1))
	SA1->(DbGoTop())
	
If MsgYesNo("Deseja incluir os cadastros para cálculo de ICMS ?","Atenção !")
	
	
	if DbSeek(xFilial("SA1")+ "900001")
	
	  AADD(aCont, cMensagem += "- Cliente:"+" "+ Alltrim(A1_COD)+STR_PULA) 
	
	Else
	
		RecLock('SA1', .T.)
		
			A1_FILIAL := FwxFilial('SA1')
			A1_COD		:= "900001"
			A1_LOJA	:= "01"
			A1_PESSOA	:= "J"
			A1_NOME 	:= "PJ ICMS/DIFAL - MG"
			A1_NREDUZ	:= "PJ ICMS/DIFAL - MG"
			A1_END		:= "Rua. Braz Leme"
			A1_TIPO	:= "F"
			A1_EST		:= "MG"
			A1_COD_MUN := "00203"
			A1_MUN		:= "ABAETE"
			A1_CONTRIB := "2"
			A1_NATUREZ := "8888888888"
			A1_CGC		:= "48431655000140"
			SA1->(MsUnlock())
  
	EndIf    
    
     
    
    
    DbSelectArea("SA2")
     SA2->(DbSetOrder(1))
     SA2->(DbGoTop())
  
	If DbSeek(xFilial("SA2")+ "888888" )
		
		 AADD(aCont, cMensagem += "- Fornecedor:"+" "+ Alltrim(A2_COD)+STR_PULA) 
	   
	Else
   
		RecLock('SA2', .T.)
		
			A2_FILIAL := FwxFilial('SA2')
			A2_COD		:= "888888"
			A2_NOME	:= "PJ ICMS - MG"
			A2_NREDUZ	:= "PJ ICMS - MG"
			A2_LOJA 	:= "01"
			A2_END 	:= "Av. Braz Leme"
			A2_EST		:= "MG"
			A2_COD_MUN	:= "00203"
			A2_MUN		:= "ABAETE"
			A2_TIPO	:= "J"
			A2_CGC 	:= "63278563000166"
			
			
			SA2->(MsUnlock())
	EndIf
    
     
    
    DbSelectArea("SF4")
    SF4->(DbSetOrder(1))
    SF4->(DbGoTop())
    
	If DbSeek(xFilial("SF4")+ "8Z0")
		
		 AADD(aCont, cMensagem += "- TES Entrada:"+" "+ Alltrim(F4_CODIGO)+STR_PULA) 
		
	Else

		RecLock('SF4', .T.)
		
		F4_FILIAL := FwXfilial('SF4')
		F4_CODIGO := "8Z0"
		F4_TIPO 	:= "S"
		F4_CREDICMS := "N"
		F4_CREDIPI := "N"
		F4_DUPLIC := "S"
		F4_ESTOQUE := "N"
		F4_PODER3 := "N"
		F4_SITTRIB := "00"
		F4_ICM := "S"
		F4_IPI := "N"
		F4_CF := "5120"
		F4_TEXTO := "Calculo ICMS/DIFAL"
		F4_LFICM := "T"
		F4_LFIPI := "N"
		F4_DESTACA := "N"
		F4_INCIDE := "N"
		F4_COMPL := "S"
		F4_DIFAL := "1"
		
		SF4->(MsUnlock())
    
	EndIf
  
     
    
    DbSelectArea("SF4")
    SF4->(DbSetOrder(1))
    SF4->(DbGoTop())

	If DbSeek(xFilial("SF4")+"4Z0")    
		
		AADD(aCont, cMensagem += "- TES Saída:"+" "+ Alltrim(F4_CODIGO)+STR_PULA)
		

	Else
		RecLock('SF4', .T.)    
		F4_FILIAL := FwXfilial('SF4')
		F4_CODIGO := "4Z0"
		F4_TIPO 	:= "E"
		F4_CREDICMS := "N"
		F4_CREDIPI := "N"
		F4_DUPLIC := "S"
		F4_ESTOQUE := "N"
		F4_PODER3 := "N"
		F4_SITTRIB := "00"
		F4_ICM := "S"
		F4_IPI := "N"
		F4_CF := "1651"
		F4_TEXTO := "Calculo ICMS"
		F4_LFICM := "T"
		F4_LFIPI := "N"
		F4_COMPL := "N"
		F4_DESTACA := "N"
		F4_INCIDE := "N"
	   F4_COMPL := "N"
		
		SF4->(MsUnlock())
	EndIf
     
    
     DbSelectArea("SB1")
     SB1->(DbSetOrder(1))
     SB1->(DbGoTop())
  
	If DbSeek(xFilial("SB1")+ "999999999999997")
		 
		AADD(aCont, cMensagem += "- Produto:"+" "+ Alltrim(B1_COD)+STR_PULA)
	
	Else
		RecLock('SB1', .T.)
		
			B1_FILIAL := FwxFilial('SB1')
			B1_COD		:= "999999999999997"
			B1_DESC	:= "Mercadoria"
			B1_TIPO	:= "ME"
			B1_UM		:= "UN"
			B1_LOCPAD	:= "01"
			B1_ORIGEM := "0"
			B1_IPI    := 5.00
			B1_LOCALIZ := "N"
			 
			
			SB1->(MsUnlock())
	EndIf  
    
    
    If len(aCont)> 0 
    			 
    MsgAlert("Você já possui os seguintes registros cadastrados para ICMS/DIFAL:"+STR_PULA+STR_PULA+cMensagem+STR_PULA+"Verifique seus cadastros ! ","- Validação de Cadastro - ")
    MsgInfo("Sua nota para cálculo de ICMS/DIFAL já pode ser lançada !","Alerta !")
    Else
    MsgInfo("Cadastros estão válidos, sua Nota para cálculo de ICMS/DIFAL já pode ser lançada !","Alerta !")
    
    EndIf
	 RestArea(aArea)
Else 
		MsgInfo("Operação abortada ! ","Atenção")
		 RestArea(aArea)
EndIf

Return
  
  

	//#007 - Cálculo de ICMS ST
User Function zCalcST()
	Local aArea    := GetArea()
  	Local aCont:= {}
 	Local cMensagem := " " 

	DbSelectArea("SA1")
	SA1->(DbSetOrder(1))
	SA1->(DbGoTop())
	
If MsgYesNo("Deseja incluir os cadastros para cálculo de ICMS ST ?","Atenção !")
	
	If DbSeek(xFilial("SA1") + "900002")
	
	AADD(aCont, cMensagem += "- Cliente: "+" "+ Alltrim(A1_COD)+STR_PULA)
	
	
	Else
		RecLock('SA1', .T.)
		
			A1_FILIAL := FwxFilial('SA1')
			A1_COD		:= "900002"
			A1_LOJA	:= "01"
			A1_PESSOA	:= "J"
			A1_NOME 	:= "PJ ICMS/ST - MG"
			A1_NREDUZ	:= "PJ ICMS/ST - MG"
			A1_END		:= "Rua. Braz Leme"
			A1_TIPO	:= "F"
			A1_EST		:= "MG"
			A1_COD_MUN := "00203"
			A1_MUN		:= "ABAETE"
			A1_CONTRIB := "N"
			A1_NATUREZ := "8888888888"
			A1_CGC		:= "63481357000159"
			SA1->(MsUnlock())
	EndIf  
    
    
    
    
    
    DbSelectArea("SA2")
     SA2->(DbSetOrder(1))
     SA2->(DbGoTop())
  
	If DbSeek(xFilial("SA2")+ "888884")
		AADD(aCont, cMensagem += "- Fornecedor: "+" "+ Alltrim(A2_COD)+STR_PULA)

	Else
     
		RecLock('SA2', .T.)
		
			A2_FILIAL := FwxFilial('SA2')
			A2_COD		:= "888884"
			A2_NOME	:= "PJ ICMS/ST - MG"
			A2_NREDUZ	:= "PJ ICMS/ST  - MG"
			A2_LOJA 	:= "01"
			A2_END 	:= "Av. Braz Leme"
			A2_EST		:= "MG"
			A2_COD_MUN	:= "00203"
			A2_MUN		:= "ABAETE"
			A2_TIPO	:= "J"
			A2_CGC 	:= "97582241000128"
			
			
			SA2->(MsUnlock())
	EndIf    
    
     
    
    DbSelectArea("SF4")
    SF4->(DbSetOrder(1))
    SF4->(DbGoTop())

	If DbSeek(xFilial("SF4")+ "8Z1")
		AADD(aCont, cMensagem += "- TES Saída: "+" "+ Alltrim(F4_CODIGO)+STR_PULA)

	Else
    
		RecLock('SF4', .T.)
		
		F4_FILIAL := FwXfilial('SF4')
		F4_CODIGO := "8Z1"
		F4_TIPO 	:= "S"
		F4_CREDICMS := "N"
		F4_CREDIPI := "N"
		F4_DUPLIC := "S"
		F4_ESTOQUE := "N"
		F4_PODER3 := "N"
		F4_SITTRIB := "60"
		F4_ICM := "S"
		F4_IPI := "N"
		F4_CF := "5120"
		F4_TEXTO := "Calculo ICMS e ST"
		F4_LFICM := "T"
		F4_LFIPI := "N"
		F4_DESTACA := "N"
		F4_INCIDE := "N"
		F4_COMPL := "S"
		F4_DIFAL := "1"
		F4_MKPCMP := "2"
		F4_MKPSOL := "2"
		
		SF4->(MsUnlock())

	EndIf
    
    
    
    DbSelectArea("SF4")
    SF4->(DbSetOrder(1))
    SF4->(DbGoTop())
 
	 If DbSeek(xFilial("SF4")+ "4Z1")
		AADD(aCont, cMensagem += "- TES Entrada: "+" "+ Alltrim(F4_CODIGO)+STR_PULA)

	Else   
		RecLock('SF4', .T.)
		
		F4_FILIAL := FwXfilial('SF4')
		F4_CODIGO := "4Z1"
		F4_TIPO 	:= "E"
		F4_CREDICMS := "N"
		F4_CREDIPI := "N"
		F4_DUPLIC := "S"
		F4_ESTOQUE := "N"
		F4_PODER3 := "N"
		F4_SITTRIB := "60"
		F4_ICM := "S"
		F4_IPI := "N"
		F4_CF := "1651"
		F4_TEXTO := "Calculo ICMS e ST"
		F4_LFICM := "T"
		F4_LFIPI := "N"
		F4_COMPL := "N"
		F4_DESTACA := "N"
		F4_INCIDE := "N"
		F4_MKPCMP := "2"
		F4_MKPSOL := "2"
		
		SF4->(MsUnlock())
	EndIf
    
     
    
    
    
	
	 DbSelectArea("SB1")
     SB1->(DbSetOrder(1))
     SB1->(DbGoTop())
  
	If DbSeek(xFilial("SB1")+ "999999999999998")
		AADD(aCont, cMensagem += "- Produto:"+" "+ Alltrim(B1_COD)+STR_PULA)

	Else
		RecLock('SB1', .T.)
		
			B1_FILIAL := FwxFilial('SB1')
			B1_COD		:= "999999999999998"
			B1_DESC	:= "Mercadoria c/ ST"
			B1_TIPO	:= "ME"
			B1_UM		:= "UN"
			B1_LOCPAD	:= "01"
			B1_ORIGEM := "0"
			B1_PICMRET := 000.01
			B1_PICMENT := 000.01
			B1_LOCALIZ := "N"
			
			
			SB1->(MsUnlock())
	EndIf  
    
    
If len(aCont)> 0 
    			 
    MsgAlert("Você já possui os seguintes registros cadastrados para ICMS ST:"+STR_PULA+STR_PULA+cMensagem+STR_PULA+"Verifique seus cadastros ! ","- Validação de Cadastro - ")
    MsgInfo("Sua nota para cálculo de ICMS ST já pode ser lançada !","Alerta !")
    Else
    MsgInfo("Cadastros estão válidos, sua Nota para cálculo de ICMS ST já pode ser lançada !","Alerta !")
    
    EndIf
	 RestArea(aArea)
Else 
		MsgInfo("Operação abortada ! ","Atenção")
		 RestArea(aArea)
EndIf

Return
  
  
  
  //#008 - Cálculo de ICMS+IPI

User Function zFisIcmIp()
  
  	Local aArea    := GetArea()
  	Local aCont:= {}
 	Local cMensagem := " " 

	DbSelectArea("SA1")
	SA1->(DbSetOrder(1))
	SA1->(DbGoTop())
	
If MsgYesNo("Deseja incluir os cadastros para Calculo de ICMS/IPI ?","Atenção !")
	
	If Dbseek(xFilial("SA1")+"900003")

		AADD(aCont, cMensagem += "- Cliente: "+" "+ Alltrim(A1_COD)+STR_PULA)
		
	Else
		RecLock('SA1', .T.)
		
			A1_FILIAL := FwxFilial('SA1')
			A1_COD		:= "900003"
			A1_LOJA	:= "01"
			A1_PESSOA	:= "J"
			A1_NOME 	:= "PJ ICMS/IPI - MG"
			A1_NREDUZ	:= "PJ ICMS/IPI - MG"
			A1_END		:= "Rua. Braz Leme"
			A1_TIPO	:= "F"
			A1_EST		:= "MG"
			A1_COD_MUN := "00203"
			A1_MUN		:= "ABAETE"
			A1_CONTRIB := "N"
			A1_CGC		:= "48431655000140"
			SA1->(MsUnlock())
  
	EndIf    
    
   
    
    
     DbSelectArea("SA2")
     SA2->(DbSetOrder(1))
     SA2->(DbGoTop())
  
	If DbSeek(xFilial("SA2")+"888887")

		AADD(aCont, cMensagem += "- Fornecedor: "+" "+ Alltrim(A2_COD)+STR_PULA)
		
	Else

		RecLock('SA2', .T.)
    
    	A2_FILIAL := FwxFilial('SA2')
    	A2_COD		:= "888887"
    	A2_NOME	:= "PJ ICMS/IPI - MG"
    	A2_NREDUZ	:= "PJ ICMS/IPI - MG"
    	A2_LOJA 	:= "01"
    	A2_END 	:= "Av. Braz Leme"
    	A2_EST		:= "MG"
    	A2_COD_MUN	:= "00203"
    	A2_MUN		:= "ABAETE"
    	A2_TIPO	:= "J"
    	A2_CGC 	:= "63278563000166"
    	SA2->(MsUnlock())
    	
	EndIf    	
    	
    	 
    
    
    
    
    DbSelectArea("SF4")
    SF4->(DbSetOrder(1))
    SF4->(DbGoTop())

	If DbSeek(xFilial("SF4")+"8Z2")
		AADD(aCont, cMensagem += "- TES Saída: "+" "+ Alltrim(F4_CODIGO)+STR_PULA)    
	   
	Else 
    
		RecLock('SF4', .T.)
		
		F4_FILIAL := FwXfilial('SF4')
		F4_CODIGO := "8Z2"
		F4_TIPO 	:= "S"
		F4_CREDICMS := "N"
		F4_CREDIPI := "N"
		F4_DUPLIC := "S"
		F4_ESTOQUE := "N"
		F4_PODER3 := "N"
		F4_SITTRIB := "00"
		F4_ICM := "S"
		F4_IPI := "S"
		F4_CF := "5120"
		F4_TEXTO := "Calculo ICMS/IPI"
		F4_LFICM := "T"
		F4_LFIPI := "T"
		F4_DESTACA := "S"
		F4_INCIDE := "N"
		F4_COMPL := "S"
		F4_DIFAL := "1"
		
		SF4->(MsUnlock())
	Endif
  
     
    
    DbSelectArea("SF4")
    SF4->(DbSetOrder(1))
    SF4->(DbGoTop())

	If DbSeek(xFilial("SF4")+"4Z2")
		AADD(aCont, cMensagem += "- TES Entrada: "+" "+ Alltrim(F4_CODIGO)+STR_PULA)  
		
	Else
  
		RecLock('SF4', .T.)
		
		F4_FILIAL := FwXfilial('SF4')
		F4_CODIGO := "4Z2"
		F4_TIPO 	:= "E"
		F4_CREDICMS := "N"
		F4_CREDIPI := "N"
		F4_DUPLIC := "S"
		F4_ESTOQUE := "N"
		F4_PODER3 := "N"
		F4_SITTRIB := "00"
		F4_ICM := "S"
		F4_IPI := "S"
		F4_CF := "1651"
		F4_TEXTO := "Calculo ICMS/IPI"
		F4_LFICM := "T"
		F4_LFIPI := "T"
		F4_DESTACA := "S"
		F4_INCIDE := "N"
	   
		
		SF4->(MsUnlock())
	EndIf
 
  	      
 If len(aCont)> 0 
    			 
    MsgAlert("Você já possui os seguintes registros cadastrados para ICMS/IPI: "+STR_PULA+STR_PULA+cMensagem+STR_PULA+"Verifique seus cadastros ! ","- Validação de Cadastro - ")
    MsgInfo("Sua nota para Cálculo de ICMS/IPI já pode ser lançada !","Alerta !")
    Else
    MsgInfo("Cadastros estão válidos, sua Nota para Cálculo de ICMS/IPI já pode ser lançada !","Alerta !")
    
    EndIf
	 RestArea(aArea)
Else 
		MsgInfo("Operação abortada ! ","Atenção")
		 RestArea(aArea)
EndIf

Return
  
 	//#009 - Cálculo Nota de Importação
User Function zImportacao()
  
	Local aArea    := GetArea()
  	Local aCont:= {}
 	Local cMensagem := " " 

	
If MsgYesNo("Deseja incluir os cadastros para Nota de Importação ?","Atenção !")
     
     DbSelectArea("SA2")
     SA2->(DbSetOrder(1))
     SA2->(DbGoTop())
  
	If DbSeek(xFilial("SA2")+"888886")
		AADD(aCont, cMensagem += "- Fornecedor: "+" "+ Alltrim(A2_COD)+STR_PULA)   

	Else	 
		  RecLock('SA2', .T.)
		
			A2_FILIAL := FwxFilial('SA2')
			A2_COD		:= "888886"
			A2_NOME	:= "PJ Nota Importação  - EX"
			A2_NREDUZ	:= "PJ Nota Importação  - EX"
			A2_LOJA 	:= "01"
			A2_END 	:= "Av. Braz Leme"
			A2_EST		:= "EX"
			A2_COD_MUN	:= "99999"
			A2_MUN		:= "Estrangeiro"
			A2_TIPO	:= "X"
			A2_CGC 	:= ""
			A2_PAIS 	:= "023"
			A2_PAISDES := "Alemanha"
    	
    	
    	SA2->(MsUnlock())
	EndIf    
    
    
    
    
    
   
    
    DbSelectArea("SF4")
    SF4->(DbSetOrder(1))
    SF4->(DbGoTop())
 
	If DbSeek(xFilial("SF4")+"4Z3")
		AADD(aCont, cMensagem += "- TES Entrada: "+" "+ Alltrim(F4_CODIGO)+STR_PULA)   

	Else	   
		RecLock('SF4', .T.)
		
		F4_FILIAL := FwXfilial('SF4')
		F4_CODIGO := "4Z3"
		F4_TIPO 	:= "E"
		F4_ICM := "S"
		F4_IPI := "S"
		F4_CF := "3101"
		F4_LFICM := "T"
		F4_LFIPI := "T"
		F4_INCIDE := "S"
		F4_AGREG := "I"
		F4_CREDICMS := "N"
		F4_CREDIPI := "N"
		F4_DUPLIC := "S"
		F4_ESTOQUE := "N"
		F4_PODER3 := "N"
		F4_SITTRIB := "00"
		F4_TEXTO := "Nota de Importação"
		F4_PISCRED := "1"
		F4_PISCOF := "3"
		F4_AGRCOF := "C"
		F4_AGRCOF := "P"
		F4_INTBSIC := "3"
		F4_DESTACA := "N"
		F4_IPIFRET := "N"
		F4_MALQCOF := 1.00 
		F4_MALQPIS := 2.00
	   
		
		SF4->(MsUnlock())
	EndIf
  
  
     DbSelectArea("SB1")
     SB1->(DbSetOrder(1))
     SB1->(DbGoTop())
  
	If DbSeek(xFilial("SB1")+ "999999999999996")
		 
		AADD(aCont, cMensagem += "- Produto:"+" "+ Alltrim(B1_COD)+STR_PULA)
	
	Else
		RecLock('SB1', .T.)
		
			B1_FILIAL := FwxFilial('SB1')
			B1_COD		:= "999999999999996"
			B1_DESC	:= "Mercadoria Importação"
			B1_TIPO	:= "ME"
			B1_UM		:= "UN"
			B1_LOCPAD	:= "01"
			B1_ORIGEM := "1"
			B1_IPI    := 5.00
			B1_LOCALIZ := "N"
			 
			
			SB1->(MsUnlock())
	EndIf  
  	   
    
 If len(aCont)> 0 
    			 
    MsgAlert("Você já possui os seguintes registros cadastrados para Importação: "+STR_PULA+STR_PULA+cMensagem+STR_PULA+"Verifique seus cadastros ! ","- Validação de Cadastro - ")
    MsgInfo("Sua Nota para Importação já pode ser lançada !","Alerta !")
    Else
    MsgInfo("Cadastros estão válidos, sua Nota para Importação já pode ser lançada !","Alerta !")
    
    EndIf
	 RestArea(aArea)
Else 
		MsgInfo("Operação abortada ! ","Atenção")
		 RestArea(aArea)
EndIf

Return
  
  
  
  //#001 - Cálculo Retenção de ISS
User Function zCalcRetIss()
    Local aArea    := GetArea()
  	Local aCont:= {}
 	Local cMensagem := " " 
     
         
     

  
   
If MsgYesNo("Deseja incluir os cadastros para Retenção de ISS ?","Atenção") 
     
     DbSelectArea("SA1")
     SA1->(DbSetOrder(1))
     SA1->(DbGoTop())
  
	If DbSeek(xFilial("SA1")+"900004")
		AADD(aCont, cMensagem += "- Cliente: "+" "+ Alltrim(A1_COD)+STR_PULA) 

	Else	
     	     
		RecLock('SA1', .T.)
	   
			A1_FILIAL := FwxFilial('SA1')
			A1_COD		:= "900004"
			A1_LOJA	:= "01"
			A1_PESSOA	:= "J"
			A1_NOME 	:= "PJ Retenção ISS - MG"
			A1_NREDUZ	:= "PJ Retenção ISS - MG"
			A1_END		:= "Rua. Braz Leme"
			A1_TIPO	:= "F"
			A1_EST		:= "MG"
			A1_COD_MUN := "00203"
			A1_MUN		:= "ABAETE"
			A1_RECISS := "1"
			A1_INCISS := "S"
			A1_NATUREZ := "9999999990"
			A1_CGC 	 := "86442330000152"
			SA1->(MsUnlock())

	EndIf  

    
     
    
    //Cadastro de Fornecedor
    
     DbSelectArea("SA2")
     SA2->(DbSetOrder(1))
     SA2->(DbGoTop())
  
  
	If DbSeek(xFilial("SA2")+"999990")
		AADD(aCont, cMensagem += "- Fornecedor: "+" "+ Alltrim(A2_COD)+STR_PULA) 

	Else	
     	 
    
		RecLock('SA2', .T.)
		
			A2_FILIAL := FwxFilial('SA2')
			A2_COD		:= "999990"
			A2_NOME	:= "PJ Retenção ISS - MG"
			A2_NREDUZ	:= "PJ Retenção ISS - MG"
			A2_LOJA 	:= "01"
			A2_END 	:= "Av. Braz Leme"
			A2_EST		:= "MG"
			A2_COD_MUN	:= "00203"
			A2_MUN		:= "ABAETE"
			A2_TIPO	:= "J"
			A2_CGC 	:= "65518213000155"
			A2_RECISS := "N"
			
			SA2->(MsUnlock())
	EndIf    
    
     
    
    
    
    //Cadastro de Natureza
    
    DbSelectArea("SED")
     SED->(DbSetOrder(1))
     SED->(DbGoTop())
  
	If DbSeek(xFilial("SED")+"9999999990")
		AADD(aCont, cMensagem += "- Natureza: "+" "+ Alltrim(ED_CODIGO)+STR_PULA)  

	Else
		RecLock('SED', .T.)
		
			ED_FILIAL := FwxFilial('SED')
			ED_CODIGO	:= "9999999990"
			ED_DESCRIC	:= "Retenção ISS"
			ED_CALCISS	:= "S"
			ED_COND	:= "R"
			
			SED->(MsUnlock())
	EndIf  
    
    
    
    
    	//Cadastro de produto
    	
     DbSelectArea("SB1")
     SB1->(DbSetOrder(1))
     SB1->(DbGoTop())
  
	If DbSeek(xFilial("SB1")+"999999999999990")
		AADD(aCont, cMensagem += "- Produto: "+" "+ Alltrim(B1_COD)+STR_PULA) 

	Else
  
		RecLock('SB1', .T.)
		
			B1_FILIAL := FwxFilial('SB1')
			B1_COD		:= "999999999999990"
			B1_DESC	:= "Retenção ISS"
			B1_TIPO	:= "ME"
			B1_UM		:= "UN"
			B1_LOCPAD	:= "01"
			B1_ORIGEM := "0"
			B1_CODISS	:= "2001"
			B1_LOCALIZ := "N"
			
			
			SB1->(MsUnlock())
	EndIf  
    
 
    
     DbSelectArea("SF4")
    SF4->(DbSetOrder(1))
    SF4->(DbGoTop())

	If DbSeek(xFilial("SF4")+"8Z3")
		AADD(aCont, cMensagem += "- TES Saída: "+" "+ Alltrim(F4_CODIGO)+STR_PULA)    
	   
	Else 
    
		RecLock('SF4', .T.)
		
		F4_FILIAL := FwXfilial('SF4')
		F4_CODIGO := "8Z3"
		F4_TIPO 	:= "S"
		F4_CREDICMS := "N"
		F4_CREDIPI := "N"
		F4_DUPLIC := "S"
		F4_ESTOQUE := "N"
		F4_PODER3 := "N"
		F4_SITTRIB := "00"
		F4_ICM := "N"
		F4_IPI := "N"
		F4_ISS := "S"
		F4_CF := "5120"
		F4_TEXTO := "Retenção ISS"
		F4_LFICM := "N"
		F4_LFIPI := "N"
		F4_LFISS := "T"
		F4_DESTACA := "N"
		F4_INCIDE := "N"
		F4_COMPL := "N"
		F4_DIFAL := "2"
		F4_MKPSOL := "1"
		
		SF4->(MsUnlock())
	Endif
  
     
    
    DbSelectArea("SF4")
    SF4->(DbSetOrder(1))
    SF4->(DbGoTop())

	If DbSeek(xFilial("SF4")+"4Z4")
		AADD(aCont, cMensagem += "- TES Entrada: "+" "+ Alltrim(F4_CODIGO)+STR_PULA)   
		
	Else
  
		RecLock('SF4', .T.)
		
		F4_FILIAL := FwXfilial('SF4')
		F4_CODIGO := "4Z4"
		F4_TIPO 	:= "E"
		F4_CREDICMS := "N"
		F4_CREDIPI := "N"
		F4_DUPLIC := "S"
		F4_ESTOQUE := "N"
		F4_PODER3 := "N"
		F4_SITTRIB := "00"
		F4_ICM := "N"
		F4_IPI := "N"
		F4_ISS := "S"
		F4_CF := "1651"
		F4_TEXTO := "Retenção ISS"
		F4_LFICM := "N"
		F4_LFIPI := "N"
		F4_LFISS := "T"
		F4_DESTACA := "N"
		F4_INCIDE := "N"
		F4_COMPL := "N"
		F4_DIFAL := "2"
	   
		
		SF4->(MsUnlock())
	EndIf
 
  	  
    
If len(aCont)> 0 
    			 
    MsgAlert("Você já possui os seguintes registros cadastrados para ISS: "+STR_PULA+STR_PULA+cMensagem+STR_PULA+"Verifique seus cadastros ! ","- Validação de Cadastro - ")
    MsgInfo("Sua Nota para Retenção de ISS já pode ser lançada !","Alerta !")
    Else
    MsgInfo("Cadastros estão válidos, sua Nota para Retenção de ISS já pode ser lançada !","Alerta !")
    
    EndIf
	 RestArea(aArea)
Else 
		MsgInfo("Operação abortada ! ","Atenção")
		 RestArea(aArea)
EndIf

Return


 

 	//#004 - Retenção SENAR + Funrural
User function zSenar()

	Local aArea    := GetArea()
  	Local aCont:= {}
 	Local cMensagem := " " 

	DbSelectArea("SA1")
	SA1->(DbSetOrder(1))
	SA1->(DbGoTop())
	
	If MsgYesNo("Deseja incluir os cadastros para cálculo de SENAR/FUNRURAL ?","Atenção !")
	
	
	If DbSeek(xFilial("SA1")+ "900005")
		
		 AADD(aCont, cMensagem += "- Cliente: "+" "+ Alltrim(A1_COD)+STR_PULA) 
		
	Else
	
		RecLock('SA1', .T.)
		
			A1_FILIAL := FwxFilial('SA1')
			A1_COD		:= "900005"
			A1_LOJA	:= "01"
			A1_PESSOA	:= "J"
			A1_NOME 	:= "PJ SENAR/FUNRURAL - MG"
			A1_NREDUZ	:= "PJ SENAR/FUNRURAL - MG"
			A1_END		:= "Rua. Braz Leme"
			A1_TIPO	:= "L"
			A1_EST		:= "MG"
			A1_COD_MUN := "00203"
			A1_MUN		:= "ABAETE"
			A1_CONTRIB := "N"
			A1_NATUREZ := "8888888882"
			A1_CGC		:= "86278394000160"
			A1_INSCRRUR := "19651985616"
			SA1->(MsUnlock())
	  
	EndIf    
    
     
    
    
    DbSelectArea("SA2")
     SA2->(DbSetOrder(1))
     SA2->(DbGoTop())
  
	If DbSeek(xFilial("SA2")+ "888882" )
		
		AADD(aCont, cMensagem += "- Fornecedor: "+" "+ Alltrim(A2_COD)+STR_PULA) 
	   
	Else
   
		RecLock('SA2', .T.)
		
			A2_FILIAL := FwxFilial('SA2')
			A2_COD		:= "888882"
			A2_NOME	:= "PF SENAR/FUNRURAL - MG"
			A2_NREDUZ	:= "PF SENAR/FUNRURAL - MG"
			A2_LOJA 	:= "01"
			A2_END 	:= "Av. Braz Leme"
			A2_EST		:= "MG"
			A2_COD_MUN	:= "00203"
			A2_MUN		:= "ABAETE"
			A2_TIPO	:= "F"
			A2_CGC 	:= "63147561623"
			A2_TIPORUR := "F"
			
			
			SA2->(MsUnlock())
	EndIf
    
     
    
    DbSelectArea("SF4")
    SF4->(DbSetOrder(1))
    SF4->(DbGoTop())
    
	If DbSeek(xFilial("SF4")+ "8Z4")
		
		AADD(aCont, cMensagem += "- TES Saída: "+" "+ Alltrim(F4_CODIGO)+STR_PULA) 
		
	Else

		RecLock('SF4', .T.)
		
		F4_FILIAL := FwXfilial('SF4')
		F4_CODIGO := "8Z4"
		F4_TIPO 	:= "S"
		F4_CREDICMS := "N"
		F4_CREDIPI := "N"
		F4_DUPLIC := "S"
		F4_ESTOQUE := "N"
		F4_PODER3 := "N"
		F4_SITTRIB := "00"
		F4_ICM := "N"
		F4_IPI := "N"
		F4_CF := "5120"
		F4_TEXTO := "Calculo SENAR/FUNRURAL"
		F4_LFICM := "T"
		F4_LFIPI := "N"
		F4_DESTACA := "N"
		F4_INCIDE := "N"
		F4_COMPL := "N"
		F4_DIFAL := "2"
		F4_BSRURAL := "1"
		F4_ALSENAR := 5.00
		F4_CONTSOC := "1"
		
		SF4->(MsUnlock())
    
	EndIf
   
    
    DbSelectArea("SF4")
    SF4->(DbSetOrder(1))
    SF4->(DbGoTop())

	If DbSeek(xFilial("SF4")+"4Z5")    
		
		AADD(aCont, cMensagem += "- TES Entrada: "+" "+ Alltrim(F4_CODIGO)+STR_PULA) 
		

	Else
		RecLock('SF4', .T.)    
		F4_FILIAL := FwXfilial('SF4')
		F4_CODIGO := "4Z5"
		F4_TIPO 	:= "E"
		F4_CREDICMS := "N"
		F4_CREDIPI := "N"
		F4_DUPLIC := "S"
		F4_ESTOQUE := "N"
		F4_PODER3 := "N"
		F4_SITTRIB := "00"
		F4_ICM := "N"
		F4_IPI := "N"
		F4_CF := "1651"
		F4_TEXTO := "Calculo SENAR/FUNRURAL"
		F4_LFICM := "T"
		F4_LFIPI := "N"
		F4_DESTACA := "N"
		F4_INCIDE := "N"
		F4_BSRURAL := "1"
		F4_CONTSOC := "1"
		F4_ALSENAR := 5.00
   
    
		SF4->(MsUnlock())
	EndIf
    
    
    
	 DbSelectArea("SB1")
     SB1->(DbSetOrder(1))
     SB1->(DbGoTop())
  
	If DbSeek(xFilial("SB1")+ "999999999999940")
		AADD(aCont, cMensagem += "- Produto: "+" "+ Alltrim(B1_COD)+STR_PULA) 

	Else
		RecLock('SB1', .T.)
		
			B1_FILIAL := FwxFilial('SB1')
			B1_COD		:= "999999999999940"
			B1_DESC	:= "Mercadoria SENAR/FUNRURAL"
			B1_TIPO	:= "ME"
			B1_UM		:= "UN"
			B1_LOCPAD	:= "01"
			B1_ORIGEM  := "0"
			B1_CONTSOC := "S"
 			
			SB1->(MsUnlock())
	EndIf  
    
    
     
    
If len(aCont)> 0 
    			 
    MsgAlert("Você já possui os seguintes registros cadastrados para SENAR/FUNRURAL: "+STR_PULA+STR_PULA+cMensagem+STR_PULA+"Verifique seus cadastros ! ","- Validação de Cadastro - ")
    MsgInfo("Sua Nota para Retenção de SENAR/FUNRURAL já pode ser lançada !","Alerta !")
    Else
    MsgInfo("Cadastros estão válidos, sua Nota para Retenção de SENAR/FUNRURAL já pode ser lançada !","Alerta !")
    
    EndIf
	 RestArea(aArea)
Else 
		MsgInfo("Operação abortada ! ","Atenção")
		 RestArea(aArea)
EndIf

Return


 	//#003 - Retenção PCC
User function RetPCC()

	Local aArea    := GetArea()
  	Local aCont	 := {}
 	Local cMensagem:= " " 
   
If MsgYesNo("Deseja incluir os cadastros para Retenção de PCC ?","Atenção") 

	DbSelectArea("SED")
     SED->(DbSetOrder(1))
     SED->(DbGoTop())
  
	If DbSeek(xFilial("SED")+"9999999989")
		AADD(aCont, cMensagem += "- Natureza: "+" "+ Alltrim(ED_CODIGO)+STR_PULA)

	Else
		RecLock('SED', .T.)
		
			ED_FILIAL := FwxFilial('SED')
			ED_CODIGO	:= "9999999989"
			ED_DESCRIC	:= "Retenção PCC"
			ED_CALCPIS	:= "S"
			ED_PERCPIS :=	0.65
			ED_CALCCOF := "S"
			ED_PERCCOF := 3.00
			ED_CALCCSL := "S"
			ED_PERCCSL := 1.00
			ED_COND	:= "R"
			
			SED->(MsUnlock())
	EndIf  
    
    
    

	DbSelectArea("SF4")
    SF4->(DbSetOrder(1))
    SF4->(DbGoTop())

	If DbSeek(xFilial("SF4")+"8Z5")
		AADD(aCont, cMensagem += "- TES Saída: "+" "+ Alltrim(F4_CODIGO)+STR_PULA)  
	   
	Else 
    
		RecLock('SF4', .T.)
		
		F4_FILIAL := FwXfilial('SF4')
		F4_CODIGO := "8Z5"
		F4_TIPO 	:= "S"
		F4_CREDICMS := "N"
		F4_CREDIPI := "N"
		F4_DUPLIC := "S"
		F4_ESTOQUE := "N"
		F4_PODER3 := "N"
		F4_SITTRIB := "00"
		F4_ICM := "N"
		F4_IPI := "N"
		F4_ISS := "N"
		F4_CF := "5120"
		F4_TEXTO := "Retenção PCC"
		F4_LFICM := "N"
		F4_LFIPI := "N"
		F4_LFISS := "T"
		F4_DESTACA := "N"
		F4_INCIDE := "N"
		F4_COMPL := "N"
		F4_PISCOF := "3"
		F4_PISCRED := "3"
		
		SF4->(MsUnlock())
	Endif
  
     
    
    DbSelectArea("SF4")
    SF4->(DbSetOrder(1))
    SF4->(DbGoTop())

	If DbSeek(xFilial("SF4")+"4Z6")
		AADD(aCont, cMensagem += "- TES Entrada: "+" "+ Alltrim(F4_CODIGO)+STR_PULA)  
		
	Else
  
		RecLock('SF4', .T.)
		
		F4_FILIAL := FwXfilial('SF4')
		F4_CODIGO := "4Z6"
		F4_TIPO 	:= "E"
		F4_CREDICMS := "N"
		F4_CREDIPI := "N"
		F4_DUPLIC := "S"
		F4_ESTOQUE := "N"
		F4_PODER3 := "N"
		F4_SITTRIB := "00"
		F4_ICM := "N"
		F4_IPI := "N"
		F4_ISS := "N"
		F4_CF := "1651"
		F4_TEXTO := "Retenção PCC"
		F4_LFICM := "N"
		F4_LFIPI := "N"
		F4_LFISS := "T"
		F4_DESTACA := "N"
		F4_INCIDE := "N"
		F4_COMPL := "N"
		F4_PISCOF := "3"
		F4_PISCRED := "3"
	   
		
		SF4->(MsUnlock())
	EndIf
 
  	   
  	  
  	  
	 DbSelectArea("SB1")
     SB1->(DbSetOrder(1))
     SB1->(DbGoTop())
  
	If DbSeek(xFilial("SB1")+ "999999999999989")
		AADD(aCont, cMensagem += "- Produto: "+" "+ Alltrim(B1_COD)+STR_PULA)

	Else
		RecLock('SB1', .T.)
		
			B1_FILIAL := FwxFilial('SB1')
			B1_COD		:= "999999999999989"
			B1_DESC	:= "RETENÇÃO PCC"
			B1_TIPO	:= "ME"
			B1_UM		:= "UN"
			B1_LOCPAD	:= "01"
			B1_ORIGEM  := "0"
			B1_PIS 	:= "1"
			B1_COFINS  := "1"
			B1_CSLL 	:= "1"
			B1_RETOPER := "2"
			B1_GARANT := "2"
			B1_LOCALIZ := "N"
			
			SB1->(MsUnlock())
	EndIf  
    
    DbSelectArea("SA1")
     SA1->(DbSetOrder(1))
     SA1->(DbGoTop())
 
  
  If DbSeek(xFilial("SA1")+ "900006")
		AADD(aCont, cMensagem += "- Cliente: "+" "+ Alltrim(A1_COD)+STR_PULA)
 
	Else
	
		RecLock('SA1', .T.)
		
			A1_FILIAL := FwxFilial('SA1')
			A1_COD		:= "900006"
			A1_LOJA	:= "01"
			A1_PESSOA	:= "J"
			A1_NOME 	:= "PJ PCC - MG"
			A1_NREDUZ	:= "PJ PCC - MG"
			A1_END		:= "Rua. Braz Leme"
			A1_TIPO	:= "F"
			A1_EST		:= "MG"
			A1_COD_MUN := "00203"
			A1_MUN		:= "ABAETE"
			A1_CONTRIB := "N"
			A1_NATUREZ := "9999999989"
			A1_CGC		:= "83797739000101" 
			A1_RECPIS := "S"
			A1_RECCOFI := "S"
			A1_RECCSLL := "S"
			A1_ABATIMP := "1"
			
			SA1->(MsUnlock())
	  
	EndIf    
    
     
    
    
     DbSelectArea("SA2")
     SA2->(DbSetOrder(1))
     SA2->(DbGoTop())
  
	If DbSeek(xFilial("SA2")+ "888880" )
		
		AADD(aCont, cMensagem += "- Fornecedor: "+" "+ Alltrim(A2_COD)+STR_PULA)
	   
	Else
   
		RecLock('SA2', .T.)
		
			A2_FILIAL := FwxFilial('SA2')
			A2_COD		:= "888880"
			A2_NOME	:= "PJ PCC - MG"
			A2_NREDUZ	:= "PJ PCC - MG"
			A2_LOJA 	:= "01"
			A2_END 	:= "Av. Braz Leme"
			A2_EST		:= "MG"
			A2_COD_MUN	:= "00203"
			A2_MUN		:= "ABAETE"
			A2_TIPO	:= "J"
			A2_CGC 	:= "65501723000110" 
			A2_RECPIS 	:= "2"
			A2_RECCOFI := "2"
			A2_RECCSLL := "2"
			
			
			SA2->(MsUnlock())
	EndIf
	
	     
    
If len(aCont)> 0 
    			 
    MsgAlert("Você já possui os seguintes registros cadastrados para PCC: "+STR_PULA+STR_PULA+cMensagem+STR_PULA+"Verifique seus cadastros ! ","- Validação de Cadastro - ")
    MsgInfo("Sua Nota para Retenção de PCC já pode ser lançada !","Alerta !")
    Else
    MsgInfo("Cadastros estão válidos, sua Nota para Retenção de PCC já pode ser lançada !","Alerta !")
    
    EndIf
	 RestArea(aArea)
Else 
		MsgInfo("Operação abortada ! ","Atenção")
		 RestArea(aArea)
EndIf

Return

/*#005 Retenção IRRF*/
User function zirrf()

Local aArea    := GetArea()
Local aCont	 := {}
Local cMensagem:= " " 


If MsgYesNo("Deseja incluir os cadastros para Retenção de IRRF ?","Atenção")
  
  DbSelectArea("SED")
  SED->(DbsetOrder(1))
  SED->(DbGoTop())
  
  If DbSeek(xFilial("SED")+ "9999999988")
  
		AADD(aCont, cMensagem += "- Natureza: "+" "+ Alltrim(ED_CODIGO)+STR_PULA)
	   
	Else
   
		RecLock('SED', .T.)
		
			ED_FILIAL := FwxFilial('SED')
			ED_CODIGO	:= "9999999988"
			ED_DESCRIC	:= "Retenção IRRF"
			ED_CALCPIS	:= "N"
			ED_PERCPIS :=	0.65
			ED_CALCCOF := "N"
			ED_PERCCOF := 3.00
			ED_CALCCSL := "N"
			ED_PERCCSL := 1.00
			ED_COND	:= "R"
			ED_CALCIRF := "S"
			ED_CALCISS := "N"
			ED_CALCINS := "N"
			ED_DEDCOF  := "2"
			ED_PERCIRF := 1.5
		
			
			SED->(MsUnlock())
	EndIf
    
    
     DbSelectArea("SA1")
     SA1->(DbSetOrder(1))
     SA1->(DbGoTop())
  
	 If DbSeek(xFilial("SA1")+"900007")
		
		AADD(aCont, cMensagem += "- Cliente: "+" "+ Alltrim(A1_COD)+STR_PULA)
	   
	Else
   
		RecLock('SA1', .T.)
		 	
			A1_FILIAL := FwxFilial('SA1')
			A1_COD		:= "900007"
			A1_LOJA	:= "01"
			A1_PESSOA	:= "J"
			A1_NOME 	:= "PJ IRRF - MG"
			A1_NREDUZ	:= "PJ IRRF - MG"
			A1_END		:= "Rua. Braz Leme"
			A1_TIPO	:= "F"
			A1_EST		:= "MG"
			A1_COD_MUN := "00203"
			A1_MUN		:= "ABAETE"
			A1_CONTRIB := "N"
			A1_NATUREZ := "9999999988"
			A1_CGC		:= "97747677000120" 
			A1_ABATIMP := "1"
			A1_RECIRRF := "1"
			A1_ABATIMP := "1"
			
			SA1->(MsUnlock())
	EndIf
	
	  DbSelectArea("SA2")
     SA2->(DbSetOrder(1))
     SA2->(DbGoTop())
  
	If DbSeek(xFilial("SA2")+ "888881" )
		
		AADD(aCont, cMensagem += "- Fornecedor: "+" "+ Alltrim(A2_COD)+STR_PULA)
	   
	Else
   
		RecLock('SA2', .T.)
		
			A2_FILIAL := FwxFilial('SA2')
			A2_COD		:= "888881"
			A2_NOME	:= "PJ IRRF - MG"
			A2_NREDUZ	:= "PJ IRRF - MG"
			A2_LOJA 	:= "01"
			A2_END 	:= "Av. Braz Leme"
			A2_EST		:= "MG"
			A2_COD_MUN	:= "00203"
			A2_MUN		:= "ABAETE"
			A2_TIPO	:= "J"
			A2_CGC 	:= "15701543000103" 
		 	A2_CALCIRF := "1"
		 	A2_MINIRF := "2"
			 
			
			
			SA2->(MsUnlock())
	EndIf
    
    DbSelectArea("SB1")
     SB1->(DbSetOrder(1))
     SB1->(DbGoTop())
  
	If DbSeek(xFilial("SB1")+ "999999999999988")
		AADD(aCont, cMensagem += "- Produto: "+" "+ Alltrim(B1_COD)+STR_PULA)

	Else
		RecLock('SB1', .T.)
		
			B1_FILIAL := FwxFilial('SB1')
			B1_COD		:= "999999999999988"
			B1_DESC	:= "RETENÇÃO IRRF"
			B1_TIPO	:= "ME"
			B1_UM		:= "UN"
			B1_LOCPAD	:= "01"
			B1_ORIGEM  := "0"
			B1_RETOPER := "2"
			B1_GARANT := "2"
			B1_IRRF   := "S"
			B1_LOCALIZ := "N"
			
			SB1->(MsUnlock())
	EndIf  
    
     DbSelectArea("SA1")
     SA1->(DbSetOrder(1))
     SA1->(DbGoTop())
  
	 If DbSeek(xFilial("SA1")+"900008")
		
		AADD(aCont, cMensagem += "- Cliente: "+" "+ Alltrim(A1_COD)+STR_PULA)
	   
	Else
   
		RecLock('SA1', .T.)
		 	
			A1_FILIAL := FwxFilial('SA1')
			A1_COD		:= "900008"
			A1_LOJA	:= "01"
			A1_PESSOA	:= "F"
			A1_NOME 	:= "PF IRRF - MG"
			A1_NREDUZ	:= "PF IRRF - MG"
			A1_END		:= "Rua. Braz Leme"
			A1_TIPO	:= "F"
			A1_EST		:= "MG"
			A1_COD_MUN := "00203"
			A1_MUN		:= "ABAETE"
			A1_CONTRIB := "N"
			A1_NATUREZ := "9999999988"
			A1_CGC		:= "46485122001" 
			A1_ABATIMP := "1"
			A1_RECIRRF := "1"
			A1_ABATIMP := "1"
			
			SA1->(MsUnlock())
	EndIf
	
	  DbSelectArea("SA2")
     SA2->(DbSetOrder(1))
     SA2->(DbGoTop())
  
	If DbSeek(xFilial("SA2")+ "888883" )
		
		AADD(aCont, cMensagem += "- Fornecedor: "+" "+ Alltrim(A2_COD)+STR_PULA)
	   
	Else
   
		RecLock('SA2', .T.)
		
			A2_FILIAL := FwxFilial('SA2')
			A2_COD		:= "888883"
			A2_NOME	:= "PF IRRF - MG"
			A2_NREDUZ	:= "PF IRRF - MG"
			A2_LOJA 	:= "01"
			A2_END 	:= "Av. Braz Leme"
			A2_EST		:= "MG"
			A2_COD_MUN	:= "00203"
			A2_MUN		:= "ABAETE"
			A2_TIPO	:= "F"
			A2_CGC 	:= "78093517456" 
		 	A2_CALCIRF := "1"
		 	A2_MINIRF := "2"
			 
			
			
			SA2->(MsUnlock())
	EndIf
    
	If len(aCont)> 0 
    			 
    MsgAlert("Você já possui os seguintes registros cadastrados para IRRF: "+STR_PULA+STR_PULA+cMensagem+STR_PULA+"Verifique seus cadastros ! ","- Validação de Cadastro - ")
    MsgInfo("Sua Nota para Retenção de IRRF já pode ser lançada !","Alerta !")
    Else
    MsgInfo("Cadastros estão válidos, sua Nota para Retenção de IRRF já pode ser lançada !","Alerta !")
    
    EndIf
	 RestArea(aArea)
Else 
		MsgInfo("Operação abortada ! ","Atenção")
		 RestArea(aArea)
EndIf

Return

User Function CalcCiap()

	Local aArea    := GetArea()
   	Local aCont:= {}
 	Local cMensagem := " " 
	Local cArq		:= "C:\tmp\log_inclusao.txt"
	Local lValid 	:= .T.

Local nLinha := 0
Local cTextoAux    := ""
   
If MsgYesNo("Deseja incluir os cadastros para CIAP ?","Atenção") 
	   
    DbSelectArea("SF4")
    SF4->(DbSetOrder(1))
    SF4->(DbGoTop())

	If DbSeek(xFilial("SF4")+"4Z7")
		AADD(aCont, cMensagem += "- TES Entrada: "+" "+ Alltrim(F4_CODIGO)+STR_PULA)  
		lValid := .F.
	Else
  
		RecLock('SF4', .T.)
		
		aCont:= {}
		AADD(aCont,{"Filial: ",F4_FILIAL := FwXfilial('SF4')})
		AADD(aCont,{"Código: ",F4_CODIGO := "4Z7"})
		AADD(aCont,{"Tipo: ", F4_TIPO 	:= "E"})
		AADD(aCont,{"Crédito ICMS:", F4_CREDICMS := "S"})
		AADD(aCont,{"Crédito IPI: ",F4_CREDIPI := "N"})
		AADD(aCont,{"Gera Duplicata: ", F4_DUPLIC := "S"})
		AADD(aCont,{"Atualiza Estoque:" ,F4_ESTOQUE := "N"})
		AADD(aCont,{"Atualiza Ativo: ", F4_ATUATF  := "S"})
		AADD(aCont,{"Poder de Terceiros: ",F4_PODER3 := "N"})
		AADD(aCont,{"CST: ", F4_SITTRIB := "00"})
		AADD(aCont,{"Calcula ICMS: ", F4_ICM := "S"})
		AADD(aCont,{"Calcula IPI: ", F4_IPI := "N"})
		AADD(aCont,{"Calcula ISS: ", F4_ISS := "N"})
		AADD(aCont,{"CFOP: ", F4_CF := "1551"})
		AADD(aCont,{"Descrição:", F4_TEXTO := "Cálculo CIAP"})
		AADD(aCont,{"Livro de ICMS: ", F4_LFICM := "O"})
		AADD(aCont,{"Livro de IPI: ", F4_LFIPI := "N"})
		AADD(aCont,{"Livro CIAP:" ,F4_CIAP  := "S"})
		AADD(aCont,{"Destaca IPI: ",F4_DESTACA := "N"})
		AADD(aCont,{"IPI na Base: ",F4_INCIDE := "N"})
		AADD(aCont,{"Calc. Dif. ICMS: ", F4_COMPL := "N"})
		AADD(aCont,{"Trib. CIAP: ",F4_CIAPTRB := "2"})
		
	   
		
		SF4->(MsUnlock())
 
    		//FWrite(nHandle,cBarra+STR_PULA+ "Fornecedor: "+ STR_PULA + cBarra+STR_PULA) 
      	cMensagem+=cBarra+STR_PULA+ "TES: "+ STR_PULA + cBarra+STR_PULA
      		For nLinha := 1 to len(aCont)
		    	 
		   
		    	//FWrite(nHandle,aCont[nLinha][1]+ cValToChar(aCont[nLinha][2])+STR_PULA)
				cMensagem+= aCont[nLinha][1]+ cValToChar(aCont[nLinha][2])+STR_PULA
				Next nLinha
      		 
 	
	EndIf  
    
		MemoWrite( cArq, cMensagem )
		//FClose(nHandle)
		 		 
		 		If lValid 
		 		
		 		AVISO("Atenção | Log de inclusão ", cMensagem, { "Salvar", "OK" }, 03)
		 		Else				
		 		AVISO("Atenção | Este registro já foi cadastrado!", cMensagem, { "Salvar", "OK" }, 03)
		 		EndIf
 		MsgInfo("Sua nota para CIAP já pode ser lançada !","Alerta !")
 	 	
     
	 //RestArea(aArea)
Else 
		MsgInfo("Operação abortada ! ","Atenção")
		
		 RestArea(aArea)
EndIf

Return

User Function facfamad()

	Local aArea    := GetArea()
   	Local aCont:= {}
 	Local cMensagem := " " 
	Local cArq		:= "C:\tmp\log_inclusao.txt"
	Local lValid 	:= .T.

Local nLinha := 0
Local cTextoAux    := ""
   
If MsgYesNo("Deseja incluir os cadastros para FETHAB/FACS ?","Atenção") 
	   
    DbSelectArea("SF4")
    SF4->(DbSetOrder(1))
    SF4->(DbGoTop())

	If DbSeek(xFilial("SF4")+"8Z8")
		AADD(aCont, cMensagem += "- TES Saída"+" "+ Alltrim(F4_CODIGO)+STR_PULA)  
		lValid := .F.
	Else
  
		RecLock('SF4', .T.)
		
		aCont:= {}
		AADD(aCont,{"Filial: ",F4_FILIAL := FwXfilial('SF4')})
		AADD(aCont,{"Código: ",F4_CODIGO := "8Z8"})
		AADD(aCont,{"Tipo: ", F4_TIPO 	:= "S"})
		AADD(aCont,{"Crédito ICMS:", F4_CREDICMS := "N"})
		AADD(aCont,{"Crédito IPI: ",F4_CREDIPI := "N"})
		AADD(aCont,{"Gera Duplicata: ", F4_DUPLIC := "S"})
		AADD(aCont,{"Atualiza Estoque:" ,F4_ESTOQUE := "N"})
		AADD(aCont,{"Atualiza Ativo: ", F4_ATUATF  := "N"})
		AADD(aCont,{"Poder de Terceiros: ",F4_PODER3 := "N"})
		AADD(aCont,{"CST: ", F4_SITTRIB := "00"})
		AADD(aCont,{"Calcula ICMS: ", F4_ICM := "N"})
		AADD(aCont,{"Calcula IPI: ", F4_IPI := "N"})
		AADD(aCont,{"Calcula ISS: ", F4_ISS := "N"})
		AADD(aCont,{"CFOP: ", F4_CF := "5120"})
		AADD(aCont,{"Descrição:", F4_TEXTO := "Cálculo FACS/FETHAB"})
		AADD(aCont,{"Livro de ICMS: ", F4_LFICM := "T"})
		AADD(aCont,{"Livro de IPI: ", F4_LFIPI := "N"})
		AADD(aCont,{"Destaca IPI: ",F4_DESTACA := "N"})
		AADD(aCont,{"IPI na Base: ",F4_INCIDE := "N"})
		AADD(aCont,{"Calc. Dif. ICMS: ", F4_COMPL := "N"})
		AADD(aCont,{"Calc. Famad: ",F4_CFAMAD  := "2"})
		AADD(aCont,{"Ret.Fethab: ", F4_RFETALG := "1"})
		AADD(aCont,{"Calc. FACS: ",F4_CFACS   := "1"})
		AADD(aCont,{"Calc. FETHAB: ", F4_CALCFET := "1"})
		
		SF4->(MsUnlock())
 
    		//FWrite(nHandle,cBarra+STR_PULA+ "Fornecedor: "+ STR_PULA + cBarra+STR_PULA) 
      		cMensagem+=cBarra+STR_PULA+ "TES: "+ STR_PULA + cBarra+STR_PULA
      		For nLinha := 1 to len(aCont)
		    	 
		   
		    	//FWrite(nHandle,aCont[nLinha][1]+ cValToChar(aCont[nLinha][2])+STR_PULA)
				cMensagem+= aCont[nLinha][1]+ cValToChar(aCont[nLinha][2])+STR_PULA
				Next nLinha
      		 
 	
	EndIf  
    
     DbSelectArea("SA1")
     SA1->(DbSetOrder(1))
     SA1->(DbGoTop())


		If dbSeek(xFilial("SA1")+ "900009" + "01")  // Se achou retorna F pois não pode dar chave duplicada
		 	
			//AADD(aCont, cMensagem += "- Cliente:"+" "+ Alltrim(A1_COD)+STR_PULA) 
		   // FWrite(nHandle, "Cliente já cadastrado ! "+ STR_PULA + cBarra+STR_PULA+"Código: 900009"+STR_PULA)
			cMensagem+= "Cliente:"+ STR_PULA+"Código: 900009"+STR_PULA+"Nome:PJ INSS - MG"+STR_PULA
			lValid 	:= .F.
		Else

		  RecLock('SA1', .T.)
		 	aCont:= {}
			AADD(aCont,{"Filial:	",SA1->A1_FILIAL := FwxFilial('SA1')})
			AADD(aCont,{"Codigo:	",SA1->A1_COD		:= "900009"})
			AADD(aCont,{"Loja:	",SA1->A1_LOJA	:= "01"})
			AADD(aCont,{"Tipo Pessoa: ",SA1->A1_PESSOA	:= "J"})
			AADD(aCont,{"Nome:	",SA1->A1_NOME 	:= "PJ FACS/FETHAB - MG"})
			AADD(aCont,{"Apelido:	",SA1->A1_NREDUZ	:= "PJ FACS/FETHAB - MG"})
			AADD(aCont,{"Endereço: "	,SA1->A1_END		:= "Rua. Braz Leme"})
			AADD(aCont,{"Tipo:	",SA1->A1_TIPO	:= "F"})
			AADD(aCont,{"Estado:	",SA1->A1_EST		:= "MG"})
			AADD(aCont,{"Cód Município:	",SA1->A1_COD_MUN := "00203"})
			AADD(aCont,{"Município:	",SA1->A1_MUN		:= "ABAETE"})
			AADD(aCont,{"Recolhe INSS:	",SA1->A1_RECINSS := "N"})--
			AADD(aCont,{"Natureza:	",SA1->A1_NATUREZ := "9999999999"})
			AADD(aCont,{"CNPJ:	",SA1->A1_CGC 	 := "67748756000194"})
			AADD(aCont,{"Rec. FETHAB: ", A1_RECFET  := "2"})
			AADD(aCont,{"Rec. FACS: ", A1_RFACS   := "2"})				
			
			SA1->(MsUnlock())
		    	//FWrite(nHandle, "Cliente: "+ STR_PULA + cBarra+STR_PULA)
		    	cMensagem+="Cliente: "+ STR_PULA + cBarra+STR_PULA
		    	For nLinha := 1 to len(aCont)
		    	 
		   
		    	//FWrite(nHandle,aCont[nLinha][1]+ cValToChar(ALLTRIM(aCont[nLinha][2]))+STR_PULA)
				cMensagem+= aCont[nLinha][1]+ cValToChar(ALLTRIM(aCont[nLinha][2]))+STR_PULA
				Next nLinha
				
		    				
		Endif


		 	//Cadastro de produto
    	
     DbSelectArea("SB1")
     SB1->(DbSetOrder(1))
     SB1->(DbGoTop())
  
    

    If DbSeek(xFilial("SB1")+ "999999999999987")
     	 
		 	//FWrite(nHandle, cBarra+STR_PULA+"Produto já cadastrado ! "+ STR_PULA + cBarra+STR_PULA+"Código: 999999999999987"+STR_PULA)
     	 
     	  cMensagem+= STR_PULA+"Produto: "+STR_PULA+"Código: 999999999999987"+STR_PULA+"Descrição: Retenção INSS"+STR_PULA
     	  lValid 	:= .F.
     	 	
    Else
     	
  		  
		RecLock('SB1', .T.)
		   aCont:= {}
			AADD(aCont,{"Filial: ",B1_FILIAL := FwxFilial('SB1')})
			AADD(aCont,{"Código: ",B1_COD		:= "999999999999987"})
			AADD(aCont,{"Descrição: ", B1_DESC	:= "Soja - FETHAB/FACS"})
			AADD(aCont,{"Tipo: ", B1_TIPO	:= "PA"})
			AADD(aCont,{"Prime. Uni.: ", B1_UM		:= "KG"})
			AADD(aCont,{"Segn. Uni.: ", B1_SEGUM		:= "TL"})
			AADD(aCont,{"Armazém: ", B1_LOCPAD	:= "01"})
			AADD(aCont,{"Origem: ", B1_ORIGEM := "0"})
			AADD(aCont,{"Contr.Endere: ",B1_LOCALIZ := "N"})
			AADD(aCont,{"Tipo FETHAB: ",B1_TFETHAB  := "1"})
			AADD(aCont,{"Alíq. FACS: ",B1_AFACS    := 1.26})
			AADD(aCont,{"Alíq. FETHAB: ",B1_AFETHAB  := 19.21}) 

			SB1->(MsUnlock())
  				//FWrite(nHandle,cBarra+STR_PULA+ "Produto: "+ STR_PULA + cBarra+STR_PULA) 
    		 cMensagem+=cBarra+STR_PULA+ "Produto: "+ STR_PULA + cBarra+STR_PULA
    		For nLinha := 1 to len(aCont)
		    	 
		   
		    	//FWrite(nHandle,aCont[nLinha][1]+ cValToChar(aCont[nLinha][2])+STR_PULA)
		    	cMensagem+= aCont[nLinha][1]+ cValToChar(aCont[nLinha][2])+STR_PULA
			Next nLinha
			 
    EndIf



		MemoWrite( cArq, cMensagem )
		//FClose(nHandle)
		 		 
		 		If lValid 
		 		
		 		AVISO("Atenção | Log de inclusão ", cMensagem, { "Salvar", "OK" }, 03)
		 		Else				
		 		AVISO("Atenção | Este registro já foi cadastrado!", cMensagem, { "Salvar", "OK" }, 03)
		 		EndIf
 		MsgInfo("Sua nota para FETHAB/FACS já pode ser lançada !","Alerta !")
 	 	
     
	 //RestArea(aArea)
Else 
		MsgInfo("Operação abortada ! ","Atenção")
		
		 RestArea(aArea)
EndIf

Return

  
User Function todos()

		
u_zCalcRetIss()
u_zCalcInss()
u_RetPCC()
u_zSenar()
u_zirrf()
u_zCalcIcms()
u_zCalcST()
u_zFisIcmIp()
u_zImportacao()
u_facfamad()

Return
	 