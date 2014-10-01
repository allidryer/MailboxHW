MailboxHW
=========
This is an iOS demo application for Dropbox.

Time spent: 14 hours spent in total

Completed user stories:

- On dragging the message left...
  - Initially, the revealed background color is gray.
  - As the reschedule icon is revealed, it starts semi-transparent and becomes fully opaque. If released at this point, the message returns to its initial position.
  - After 60 pts, the later icon starts moving with the translation and the background changes to yellow.
  - Upon release, the message continues to reveal the yellow background. When the animation is complete, it shows the reschedule options.
  - After 260 pts, the icon changes to the list icon and the background color changes to brown.
  - Upon release, the message continues to reveal the brown background. When the animation is complete, it shows the list options.
  - User can tap to dismiss the reschedule or list options. After the reschedule or list options are dismissed, you should see the message finish the hide animation.
- On dragging the message right...
  - Initially, the revealed background color is gray.
  - As the archive icon is revealed, it starts semi-transparent and becomes fully opaque. If released at this point, the message returns to its initial position.
  - After 60 pts, the archive icon starts moving with the translation and the background changes to green.
  - Upon release, the message continues to reveal the green background. When the animation is complete, it hides the message.
  - After 260 pts, the icon changes to the delete icon and the background color changes to red.
  - Upon release, the message continues to reveal the red background. When the animation is complete, it hides the message.
- Optional: Panning from the edge reveals the menu
- Optional: If the menu is being revealed when the user lifts their finger, it continues revealing.
- Optional: If the menu is being hidden when the user lifts their finger, it continues hiding.

Walkthrough of all user stories:

![alt tag](https://github.com/allidryer/MailboxHW/blob/master/MailboxHW.gif)

GIF created with LiceCap.
