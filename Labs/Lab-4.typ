#import "Class.typ": *


#show: ieee.with(
  title: [#text(smallcaps("Lab #4: ROS2 using RCLPY in Julia"))],
  /*
  abstract: [
    #lorem(10).
  ],
  */
  authors:
  (
  

    
    (
      name: "Samar trabelsi",
      department: [Dept. of EE],
      organization: [ISET Bizerte --- Tunisia],
      profile: "Satrabelsi",
    ),
    (
      name: "Nehed Ouhibi",
      department: [Dept. of EE],
      organization: [ISET Bizerte --- Tunisia],
      profile: "N1ehed",
    ),
  


  )
  // index-terms: (""),
  // bibliography-file: "Biblio.bib",
)

we are required to carry out this lab using the REPL as in @fig:repl.

#figure(
	image("Images/REPL.png", width: 100%, fit: "contain"),
	caption: "Julia REPL"
	) <fig:repl>
	
#exo[Minimal Publisher/Subscriber Setup][The combination of Julia and rclpy opens up opportunities for developing efficient and performant robotics applications with the benefits of ROS2s ecosystem.]

Make sure to read the instructions thoroughly, follow each step precisely, and ask for clarification if needed.

We begin first of all by sourcing our ROS2 installation as follows:
```zsh
source /opt/ros/humble/setup.zsh
```

#solution[Always start by sourcing ROS2 installation in any newly opened terminal.]

Open a _tmux_ session and write the instructions provided at your Julia REPL.

#let publisher=read("../Codes/ros2/publisher.jl")
#let subscriber=read("../Codes/ros2/subscriber.jl")

#raw(publisher, lang: "julia")
This is a Julia script that uses the PyCall package to interface with ROS2 (Robot Operating System 2) via its Python API. Here's a breakdown of what the code does:

1. Imports: The `pyimport` function is used to import Python modules into Julia. Here, it's importing `rclpy` (the main ROS2 Python module) and `std_msgs.msg` (a standard message type in ROS2).

2. Initialize ROS2: `rclpy.init()` initializes the ROS2 runtime system.

3. Create Node: `rclpy.create_node("my_publisher")` creates a new ROS2 node named "my_publisher". A node is an entity that processes data. `rclpy.spin_once(node, timeout_sec=1)` allows the node to process its callbacks once.

4. Create Publisher: `node.create_publisher(str.String, "infodev", 10)` creates a publisher that can send messages of type `std_msgs.msg.String` on the "infodev" topic. The `10` is the queue size for outgoing messages.

5. Publish Messages: The `for` loop creates a new `std_msgs.msg.String` message, publishes it on the "infodev" topic, logs the message data with the prefix "[TALKER]", and then waits for 1 second. This is done 100 times.

6. Cleanup: Finally, `rclpy.shutdown()` shuts down the ROS2 runtime system and `node.destroy_node()` destroys the node.

In summary, this script creates a ROS2 node that publishes a series of string messages ("Hello, ROS2 from Julia! (i)") to the "infodev" topic. It's a basic example of a publisher node in ROS2. 

In a newly opened terminal, we need to setup a subscriber that listens to the messages being broadcasted by our previous publisher#footnote[Remember to source ROS2 installation before using it with Julia].

#raw(subscriber, lang: "julia")

 This is another Julia script that uses the PyCall package to interface with ROS2 (Robot Operating System 2) via its Python API. However, unlike the previous script, this one creates a subscriber node in ROS2. Here's a breakdown of what the code does:

1. Imports: The `pyimport` function is used to import Python modules into Julia. Here, it's importing `rclpy` (the main ROS2 Python module) and `std_msgs.msg` (a standard message type in ROS2).

2. Initialize ROS2: `rclpy.init()` initializes the ROS2 runtime system.

3. Create Node: `rclpy.create_node("my_subscriber")` creates a new ROS2 node named "my_subscriber". A node is an entity that processes data.

4. Callback Function: The `callback` function is defined to process incoming messages. When a message is received, it logs the message data with the prefix "[LISTENER] I heard: ".

5. Create Subscription: `node.create_subscription(str.String, "infodev", callback, 10)` creates a subscription that listens for messages of type `std_msgs.msg.String` on the "infodev" topic. The `callback` function is called for each incoming message. The `10` is the queue size for incoming messages.

6. Spin: The `while` loop keeps the node running and processing its callbacks (i.e., the `callback` function) as long as ROS2 is still running (`rclpy.ok()` returns `true`).

7. Cleanup: Finally, `node.destroy_node()` destroys the node and `rclpy.shutdown()` shuts down the ROS2 runtime system.

In summary, this script creates a ROS2 node that listens for string messages on the "infodev" topic and logs each message it receives. 

The graphical tool *rqt_graph* of @fig:rqt_graph displays the flow of data between our nodes: #emph[my_publisher] and #emph[my_subscriber], through the topic we designed _infodev_. //It can be launched using the following commands:

```zsh
source /opt/ros/humble/setup.zsh
rqt_graph
```

#figure(
	image("Images/rqt_graph.png", width: 100%),
	caption: "rqt_graph",
) <fig:rqt_graph>

@fig:pub-sub depicts the publication and reception of the message _"Hello, ROS2 from Julia!"_ in a terminal. The left part of the terminal showcases the message being published, while the right part demonstrates how the message is being received and heard.

#figure(
	image("Images/pub-sub.png", width: 100%),
	caption: "Minimal publisher/subscriber in ROS2",
) <fig:pub-sub>

@fig:topic-list shows the current active topics, along their corresponding interfaces.

/*
```zsh
source /opt/ros/humble/setup.zsh
ros2 topic list -t
```
*/

#figure(
	image("Images/topic-list.png", width: 100%),
	caption: "List of topics",
) <fig:topic-list>

//#test[Some test]

