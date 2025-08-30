namespace Sucasuc.Omip.Utilities;
/// <summary>
/// Codeunit SUC Omip Email Message (ID 50154).
/// </summary>
codeunit 50154 "SUC Omip Email Management"
{
    /// <summary>
    /// BodyBackground.
    /// </summary>
    /// <param name="Backgroundcolor">Text.</param>
    /// <returns>Return value of type Text.</returns>
    procedure BodyBackground(Backgroundcolor: Text): Text
    begin
        exit('<table style="max-width: 1500px; width: 100%; background-color:' + Backgroundcolor + '; padding-left: 10px; padding-right: 10px; line-height: 1.5em;" width="100%" cellspacing="0" cellpadding="0" bgcolor="#FFFFFF" align="center">' +
             ' <tbody>' +
             '  <tr>' +
             '   <td style="max-width: 1500px; width: 100%; padding: 20px;"></td>' +
             '  </tr>' +
             ' </tbody>' +
             '</table>');
    end;

    /// <summary>
    /// HeaderHTML.
    /// </summary>
    /// <param name="StyleColor">Text.</param>
    /// <returns>Return value of type Text.</returns>
    procedure HeaderHTML(StyleColor: Text): Text
    begin
        exit('<!DOCTYPE html>' +
             '<html style="margin-top: 0px;">' +
             '<head>' +
             '  <meta http-equiv="content-type" content="text/html; charset=utf-8">' +
             '  <meta name="viewport" content="width=device-width">' +
             '  <style>' +
             '    a {' +
             '      color: ' + StyleColor + ';' +
             '    }' +
             '  </style>' +
             '</head>');
    end;
}