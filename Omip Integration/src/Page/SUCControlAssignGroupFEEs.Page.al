namespace Sucasuc.Omip.User;
using Sucasuc.Omip.Masters;
page 50254 "SUC Control Assign Group FEEs"
{
    PageType = StandardDialog;
    ApplicationArea = All;
    UsageCategory = None;
    Caption = 'Control Assign Group FEEs';

    layout
    {
        area(Content)
        {
            group(Options)
            {
                Caption = 'Options';
                field(Groups; Groups)
                {
                    Caption = 'Groups';
                    TableRelation = "SUC Omip FEE Groups";
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        SUCOmipFEEGroups: Record "SUC Omip FEE Groups";
                        SUCOmipFEEGroupsP: Page "SUC Omip FEE Groups";
                    begin
                        SUCOmipFEEGroups.Reset();
                        if SUCOmipFEEGroups.FindSet() then begin
                            SUCOmipFEEGroupsP.SetRecord(SUCOmipFEEGroups);
                            SUCOmipFEEGroupsP.SetTableView(SUCOmipFEEGroups);
                            SUCOmipFEEGroupsP.LookupMode(true);
                            if SUCOmipFEEGroupsP.RunModal() = Action::LookupOK then begin
                                SUCOmipFEEGroupsP.GetRecord(SUCOmipFEEGroups);
                                if Groups <> '' then
                                    Groups += '|' + SUCOmipFEEGroups."Group Id."
                                else
                                    Groups := SUCOmipFEEGroups."Group Id.";
                            end;
                        end;
                    end;
                }
            }
        }
    }

    // actions
    // {
    //     area(Processing)
    //     {
    //         action(ActionName)
    //         {

    //             trigger OnAction()
    //             begin

    //             end;
    //         }
    //     }
    // }
    var
        Groups: Code[250];

    procedure GetDataGroups(var GroupsOut: Code[250])
    begin
        GroupsOut := Groups;
    end;
}