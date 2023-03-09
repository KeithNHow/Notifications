/// <summary>
/// PageExtension "KNH_CreditBalanceNotification" (ID 62040) extends Record Sales Order.
/// </summary>
pageextension 52020 KNH_CreditBalanceNotification extends "Sales Order"
{
    trigger OnOpenPage()
    var
        Customer: Record Customer;
        CreditBalanceNotification: Notification;
        BalanceMsg: Label 'The current balance exceeds the credit limit.';
        ChgCredLimitMsg: Label 'Change credit limit';
    begin
        Customer.Get(Rec."Sell-to Customer No.");
        if Customer."Balance (LCY)" > Customer."Credit Limit (LCY)" then begin
            Message('Found');
            CreditBalanceNotification.Message(BalanceMsg); //Create the notification
            CreditBalanceNotification.Scope := NotificationScope::LocalScope;
            CreditBalanceNotification.SetData('CustNumber', Customer."No."); //Add a data property for the customer number
            CreditBalanceNotification.AddAction(ChgCredLimitMsg, Codeunit::"KNH_ActionHandler", 'OpenCustomer');   //Add an action, call the ActionHandler codeunit
            CreditBalanceNotification.Send(); //Send the notification to the client.
        end;
    end;
}
