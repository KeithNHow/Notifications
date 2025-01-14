/// <summary>
/// Codeunit "KNHActionHandler" (ID 62040).
/// </summary>
codeunit 52020 KNHActionHandler
{
    /// <summary>
    /// OpenCustomer.
    /// </summary>
    /// <param name="CreditBalanceNotification">Notification.</param>
    procedure OpenCustomer(CreditBalanceNotification: Notification)
    var
        CustomerRec: Record Customer;
        CustomerCard: Page "Customer Card";
        CustNo: Text;
        CustMissingMsg: Label 'Could not find Customer: %1', Comment = '%1 = Customer No.';
    begin
        CustNo := CreditBalanceNotification.GetData('CustNumber'); //Get the customer number data 
        if CustomerRec.Get(CustNo) then begin //Open the Customer Card page
            CustomerCard.SetRecord(CustomerRec);
            CustomerCard.Run();
        end else
            Error(CustMissingMsg, CustNo);
    end;
}
