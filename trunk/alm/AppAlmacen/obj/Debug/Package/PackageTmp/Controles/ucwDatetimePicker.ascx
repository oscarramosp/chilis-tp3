<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucwDatetimePicker.ascx.cs" Inherits="ucwDatetimePicker" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

  <asp:TextBox ID="txtDate1" runat="server"></asp:TextBox>
          <asp:Image ID="Image1" runat="server" Height="19px" 
          ImageUrl="~/Imagenes/Iconos/ico_calendario.png" />
          <cc1:CalendarExtender ID="CalendarExtender1" runat="server" 
           TargetControlID="txtDate1" PopupButtonID="Image1"  >
         </cc1:CalendarExtender>
