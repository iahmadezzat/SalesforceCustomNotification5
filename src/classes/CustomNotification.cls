/**
 * Created by Ahmad on 7/12/2020.
 */

public with sharing class CustomNotification {

    private String notificationTypeId;
    private String notificationTypeName;
    private String notificationBody;
    private String notificationTitle;
    private List<Id> recipientIds;
    private Id targetId;
    private Id senderId;

    public CustomNotification() {
        this.targetId = UserInfo.getUserId();
    }

    public CustomNotification type(String type) {
        this.notificationTypeName = type;
        return this;
    }

    public CustomNotification title(String title) {
        this.notificationTitle = title;
        return this;
    }

    public CustomNotification body(String body) {
        this.notificationBody = body;
        return this;
    }

    public CustomNotification sendToCurrentUser() {
        this.recipientIds = new List<Id>{
                UserInfo.getUserId()
        };
        return send();
    }

    // TODO: Add more methods to add multiple recipients for example
    // ...

    public CustomNotification send() {
        new FlowProcess()
                .named('SendCustomNotifications')
                .with('CustomNotificationTypeName', this.notificationTypeName)
                .with('NotificationBody', this.notificationBody)
                .with('NotificationTitle', this.notificationTitle)
                .with('RecipientIds', this.recipientIds)
                .with('TargetId', this.targetId)
                .run();
        // TODO: Error handling
        // ...
        return this;
    }
}