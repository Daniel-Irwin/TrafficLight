# TrafficLight
Traffic Light Finite State Machine

This is an implementation of a finite state machine for a padestrian traffic light.

The first state is a green light. When a button is pressed a timer is activated. When that timer goes to 0, the next state is a yellow light.

The light remains yellow for several seconds, then goes red for 60 seconds. 

Then goes back to yellow, then green again where it waits for the button push signal again.

![image](https://user-images.githubusercontent.com/19673047/220207501-eb43e6e5-7e07-419d-bbce-797ab51ade52.png)
