PROCEDURE DrawLine:
  DEFINE INPUT  PARAMETER FromX      AS INTEGER    NO-UNDO.
  DEFINE INPUT  PARAMETER FromY      AS INTEGER    NO-UNDO.
  DEFINE INPUT  PARAMETER ToX        AS INTEGER    NO-UNDO.
  DEFINE INPUT  PARAMETER ToY        AS INTEGER    NO-UNDO.
  DEFINE INPUT  PARAMETER iThickness AS INTEGER    NO-UNDO.
  DEFINE INPUT  PARAMETER iStyle     AS INTEGER    NO-UNDO.
  DEFINE INPUT  PARAMETER rgbColor   AS INTEGER    NO-UNDO.
  
  DEF VAR hdc AS INTEGER NO-UNDO.
  DEF VAR hpen AS INTEGER NO-UNDO.
  DEF VAR Okay AS INTEGER NO-UNDO.
  DEFINE VARIABLE lptr AS MEMPTR     NO-UNDO.
  
  RUN GetDC (INPUT FRAME f-Graf:HWND, 
             OUTPUT hdc).
 
  RUN CreatePen (iStyle,
                 iThickness, 
                 rgbColor,
                 OUTPUT hPen).

  RUN SelectObject (hdc, hPen).

  SET-SIZE(lptr) = 1.  /*do not know the point of this pointer*/
  PUT-BYTE(lptr,1) = 0.
  RUN MoveToEx (hdc,
                FromX,
                FromY,
                lptr).
  SET-SIZE(lptr) = 0. /*release that mptr*/
                          
  RUN LineTo (hdc,
              ToX, 
              ToY).
  RUN DeleteObject (hPen).
  
  RUN ReleaseDC (INPUT FRAME f-Graf:HWND, 
                 INPUT hdc, 
                 OUTPUT Okay).

END PROCEDURE.

PROCEDURE initialize-controls :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------
  Purpose:     listen for WM_ERASEBKGND messages
------------------------------------------------------------------------------*/
  chCtrlFrame:Msgblst32:MsgList(0)    = 20.    /* = WM_ERASEBKGND */
  chCtrlFrame:Msgblst32:MsgPassage(0) = -1.    /* = let PSC handle the message first */
  chCtrlFrame:Msgblst32:hWndTarget    = FRAME {1}:HWND.

END PROCEDURE.
