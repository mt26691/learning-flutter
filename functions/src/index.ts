import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
// // Start writing Firebase Functions
// // https://firebase.google.com/docs/functions/typescript
//
export const myFunction = functions.firestore.document('chat/{message}')
    .onCreate((snapshot, context) => {
        return admin.messaging().sendToTopic('chat', {
            notification: {
                title: snapshot.data().username,
                body: snapshot.data().text,
                clickAction: 'FLUTTER_NOTIFICATION_CLICK'
            }
        });
    });


