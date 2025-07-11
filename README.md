# ESP32-S3 Control Panel

Below is an application in which the previously implemented (https://github.com/mk590901/ECG-MQTT-SERVICE) __mqtt service__ is used as a __app core__ for the control panel for the microcontroller on the __ESP32-S3-WROOM__ board.

## Brief service's description

In fact, all control of the controller comes down to changing the color of the __RGB LED__ on the board, so the service is simplified and its functions are reduced to sending commands to change the color and receiving a response.

## Brief GUI description

__GUI__ includes control panel and the mqtt indicator panel. The controller panel is supplemented with a __Stop ESP32-S3__ button, pressing which leads to the end of the application on the controller.

In addition to the service __control panel__ and the __mqtt indicator__ panel, the __GUI__ is supplemented with a panel of __buttons__, by pressing which you can change the color of the __RGB LED__ of __ESP32-S3__ controller. At the bottom of the screen there is an __indicator__ of the selected color. It changes when the application receives asknowledge from the controller.

More details about the command system used and they structure are in the README.md file of the https://github.com/mk590901/TOIT-MQTT-Service repository.

## Movies

Below are two movies:

> Flutter application via that changes colors on the board of microcontroller. You need to press the __Start__ button and after a successful connection to the broker (two green icons - a sign of a successful connection and subscription) you can select a color for the RGB LED. With a slight delay, the color of the ring at the bottom of the screen changes because the reverse passage of the command from the __ESP32-S3__ to the application take anu time. You can also interrupt the application on the __ESP32-S3__ by pressing the __Stop ESP32-S3__ button. If you want to continue, then load the application again to the chip using the __jag__ command.

https://github.com/user-attachments/assets/204586d2-98a7-4bbd-803a-4a50d9745073

> Live lideo of the  reflection of interaction application 1) with the __ESP32-S3-WROOM__ board.

https://github.com/user-attachments/assets/21566884-27eb-49b7-a5bc-776038f8a3ae




