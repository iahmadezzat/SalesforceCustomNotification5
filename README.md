# Salesforce Custom Notification
Send a custom bell notification using Apex API for Mobile and Desktop.

There is no way to send custom notifications directly using Apex, and [REST](https://developer.salesforce.com/docs/atlas.en-us.api_action.meta/api_action/actions_obj_custom_notification.htm) or [SOAP](https://developer.salesforce.com/docs/atlas.en-us.226.0.api_meta.meta/api_meta/meta_customnotificationtype.htm) APIs must be used. <br/>So instead, this hack allows sending custom notification through Apex API.

## Custom Notification Types
First, a custom notification type must be exist.
To create a new one, from Notification Builder in Setup menu, enter Custom Notifications. Click New, enter name 'MyCustomNotification' as its API Name is used later in Apex, then select supported channels.

## ***SendCustomNotifications*** Flow
Second, a Flow named ***SendCustomNotifications*** must be created, that can be invoked by other flows, with these Elements and Resources:

<p align="center">
<img src="https://i.imgur.com/rivzagy.png" width ="80%" alt="PacketSniffer App">
</p>

1. "Send Custom Notification" core action
    - CustomNotificationTypeId
    - CustomNotificationTypeName
    - NotificationBody
    - NotificationTitle
    - SenderId
    - TargetId
    - RecipientIds
        - All with Resource Type: Variable, Data Type: Text, and ✓ Available for input. 
        - RecipientIds is exacalty the same with allowing multiple values (collection variable)
2. Get Records Element, *Get CustomNotificationType Id*
    - Object: Custom Notification Type
    - Condition: CustomNotifTypeName **Equals** {!CustomNotificationTypeName}
    - Store Record Data: Choose fields and assign variables, in separate variables 
        - Field: Id → Variable: {!CustomNotificationTypeId}
        
## Apex
Simply, ***SendCustomNotification*** Class represents an interface to push any type of custom notifications calling this statement:
```
new CustomNotification()    
    .type('MyCustomNotification')   
    .title('Notification Title')
    .body('Body Information')
    .sendToCurrentUser();
```
Automated notificaions can be configured in triggers, *for instance:*

```
trigger AccountTrigger on Account (after insert) {
new CustomNotification()    
    .type('MyCustomNotification')   
    .title('New Accounts have been inserted')
    .body('There are ' + String.valueOf(Trigger.new.size()) + ' accounts have been inserted')
    .sendToCurrentUser();
}
```
<p align="right">
<img src="https://i.imgur.com/GLfS73s.png" width ="50%" alt="PacketSniffer App">
</p>
