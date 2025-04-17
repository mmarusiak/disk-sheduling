# Disk Sheduling
*Project for Operating Systems class 2024/2025*  
[Post on my website](https://mmarusiak.github.io/Posts/disk-sheduling.html)  
Author: Marcel Marusiak


## PROBLEM OVERVIEW
In Hard Disk Drives (HDDs), data is stored on spinning disks. To access data, the disk arm moves to the right track. Since this movement takes time, disk scheduling is needed to decide the order of pending read/write requests, aiming to reduce total seek time.

I've made a simple simulation of disk scheduling in Java, Processing framework inspired by Daniel Shiffman's Coding Train series. You can find the code in my GitHub repository here.

## PROBLEM INTRODUCTION
First, let's define what we will consider a disk. For us, a disk is a linearly ordered sequence of blocks. Processes can be executed from a specific place in memory, and for our simulation, this will simply be a position in the sequence of blocks – a specific block.

For the disk head – the part that reads and writes data – we define different movement algorithms. We define them, of course, in the context of the processes that appear on the disk. Moving to the next block takes one unit of time.

So, processes appear at specific locations on the disk, and we need to create an algorithm that will execute them as quickly as possible. In this article, I will present several algorithms that are used in real hard disk drives. It is worth noting that for SSDs, such algorithms are not needed, because they do not have a head, and access to data is practically instantaneous. For such disks, we use different solutions – HIOS.

Later we will discuss how to handle processes which have some deadlines!

**Criteria for disk scheduling algorithms**

There are several criteria for evaluating disk scheduling algorithms. The most important ones are:
* Moves of disk arm: amount of moves that arm will make.
* Average waiting times for processes: average waiting time that process needs to wait for arm to arrive.
* Starved processes: amount of processes that waited too long.
* Killed processes: amount of processes that exceeded deadline and were not processes in time.

## LET'S TALK ABOUT ALGORITHMS
**FCFS**

First-Come, First-Served (FCFS) is the simplest disk scheduling algorithm. It processes requests in the order they arrive. The disk head moves to the requested block, executes the process, and then moves to the next request. This algorithm is easy to implement but can lead to long wait times, especially if a request is far from the current position of the disk head.
Let's see how would such algorithm work on our disk:

![FCFS](https://raw.githubusercontent.com/mmarusiak/mmarusiak.github.io/refs/heads/main/Posts/posts-materials/disk-sheduling/FCFS.gif)

**SSTF**

Shortest Seek Time First (SSTF) is a more efficient algorithm than FCFS. It selects the request that is closest to the current position of the disk head. This reduces the average wait time for processes, but it can lead to starvation for requests that are far from the current position of the disk head. It can also lead to a situation where the disk head moves back and forth between two requests, causing unnecessary delays and starvation for other requests.
It also read all processes in the way, so while travelling to the closest one, it will read all processes in the way.
Let's see how would such algorithm work on our disk:

![SSTF](https://raw.githubusercontent.com/mmarusiak/mmarusiak.github.io/refs/heads/main/Posts/posts-materials/disk-sheduling/SSTF.gif)

**Scan**

Scan is a more advanced algorithm that moves the disk head in one direction until it reaches the end of the disk, then reverses direction and processes requests in the opposite direction. This algorithm is more efficient than FCFS and SSTF, as it reduces the average wait time for processes and prevents starvation. However, it can still lead to long wait times for requests that are far from the current position of the disk head.
Let's see how would such algorithm work on our disk:

![SCAN](https://raw.githubusercontent.com/mmarusiak/mmarusiak.github.io/refs/heads/main/Posts/posts-materials/disk-sheduling/SCAN.gif)

**C-Scan**

C-Scan (Circular Scan) is a variation of the Scan algorithm. It moves the disk head in one direction until it reaches the end of the disk, then jumps back to the beginning and continues processing requests in the same direction. This algorithm is more efficient than Scan, as it reduces the average wait time for processes and prevents starvation. However, it can still lead to long wait times for requests that are far from the current position of the disk head.
Let's see how would such algorithm work on our disk:

![CScan](https://raw.githubusercontent.com/mmarusiak/mmarusiak.github.io/refs/heads/main/Posts/posts-materials/disk-sheduling/CSCAN.gif)

## COMPARISON
General comparison for random generated processes:

![Comparison1](https://raw.githubusercontent.com/mmarusiak/mmarusiak.github.io/refs/heads/main/Posts/posts-materials/disk-sheduling/c1.gif)

FCFS is by far the slowest algorithm, as it does not take into account the position of the disk head. Now let's see some statistics for each algorithm:

| Starved Processes | Arm Moves | Avg waiting times|
|-------------------|-----------|------------------|
| ![Starved](https://raw.githubusercontent.com/mmarusiak/mmarusiak.github.io/refs/heads/main/Posts/posts-materials/disk-sheduling/starved1.png)| ![Moves](https://raw.githubusercontent.com/mmarusiak/mmarusiak.github.io/refs/heads/main/Posts/posts-materials/disk-sheduling/moves.png)| ![avg waiting times](https://raw.githubusercontent.com/mmarusiak/mmarusiak.github.io/refs/heads/main/Posts/posts-materials/disk-sheduling/avg.png)|


**Edge cases:**

First, what if processes will appear only in two edges of the disk? It may cause starvation for SSTF, because it will always choose the closest process and will not move to the other edge:
![edge case](https://raw.githubusercontent.com/mmarusiak/mmarusiak.github.io/refs/heads/main/Posts/posts-materials/disk-sheduling/edgecase1.gif)

As we can see SSTF is not moving to other edge, which causes starvation for processes on the other edge.

| Starved Processes | Arm Moves | Avg waiting times|
|-------------------|-----------|------------------|
| ![Starved](https://raw.githubusercontent.com/mmarusiak/mmarusiak.github.io/refs/heads/main/Posts/posts-materials/disk-sheduling/starvededge1.png)| ![Moves](https://raw.githubusercontent.com/mmarusiak/mmarusiak.github.io/refs/heads/main/Posts/posts-materials/disk-sheduling/movesedge1.png)| ![avg waiting times](https://raw.githubusercontent.com/mmarusiak/mmarusiak.github.io/refs/heads/main/Posts/posts-materials/disk-sheduling/avgedge1.png)|

As we can see SSTF is causing processes to starve, and average waiting time is the highest.

Now let's take edge case for Scan and C-Scan algorithms. What if processes will appear behind arm of the disk?

We must notice that if we want to generate same set of processes for all algorithms, we need to choose one, because arm position will be different for each algorithm. We can also generate processes for each algorithm separately, and we will take into account that arm position will be different for each algorithm.

| Same generator for all algorithms | Each algorithm has its own generator |
|-----------------------------------|--------------------------------------|
| ![Generator 1](https://raw.githubusercontent.com/mmarusiak/mmarusiak.github.io/refs/heads/main/Posts/posts-materials/disk-sheduling/edgecase2.gif) | ![Generator 1](https://raw.githubusercontent.com/mmarusiak/mmarusiak.github.io/refs/heads/main/Posts/posts-materials/disk-sheduling/edgecase2.gif) |


We can see that generating processes in 2 scenarios will give us very comparable results. Only C-Scan algorithm will have significant change if we will generate processes for algorithms separately. SSTF and FCFS will have similar results in both scenarios, because they will catch processes or will be stuck between two positions where processes are.

| Starved Processes | Arm Moves | Avg waiting times|
|-------------------|-----------|------------------|
| ![Starved](https://raw.githubusercontent.com/mmarusiak/mmarusiak.github.io/refs/heads/main/Posts/posts-materials/disk-sheduling/starvededge2.png)| ![Moves](https://raw.githubusercontent.com/mmarusiak/mmarusiak.github.io/refs/heads/main/Posts/posts-materials/disk-sheduling/movesedge2.png)| ![avg waiting times](https://raw.githubusercontent.com/mmarusiak/mmarusiak.github.io/refs/heads/main/Posts/posts-materials/disk-sheduling/avgedge2.png)|

As we can see C-Scan and Scan are causing processes to starve, and average waiting time is the highest.

## REAL TIME PROCESSES - PROCESSES WITH DEADLINES

Let's introduce a new type of process - real time process. Such process has a deadline, and if it is not executed in time, it is killed. We can introduce a new parameter - deadline. It is a time when process must be executed. Those processes will be colored to red and disappear if killed or executed.

| Red processes are processes with deadlines | Killed processes - processes not executed in deadline |
|-----------------------------------|--------------------------------------|
| ![Algorithms with deadlines](https://raw.githubusercontent.com/mmarusiak/mmarusiak.github.io/refs/heads/main/Posts/posts-materials/disk-sheduling/killed.gif) | ![killed](https://raw.githubusercontent.com/mmarusiak/mmarusiak.github.io/refs/heads/main/Posts/posts-materials/disk-sheduling/killed.png) |

Real time processes algorithms are similar to those for normal processes. Even more, they use as "wrapper" - if there are no processes with deadline we use normal algorithm, if there is we use special algorithm for real time processes.

We have 2 main algorithms that I will discuss here:

**EDF**

Earliest Deadline First (EDF) is a real-time scheduling algorithm that selects the request with the earliest deadline. This algorithm is more efficient than FCFS and SSTF, as it reduces the average wait time for processes and prevents starvation. However, it can still lead to long wait times for requests that are far from the current position of the disk head.

However we have no guarantee that we will be able to execute all processes in time.
We do not execute processes in way.

**FD-Scan**

FD-Scan (Fixed Deadline Scan) is a variation of the Scan algorithm. It moves the disk head in one direction until it reaches the end of the disk, then reverses direction and processes requests in the opposite direction. This algorithm is more efficient than FCFS and SSTF, as it reduces the average wait time for processes and prevents starvation. However, it can still lead to long wait times for requests that are far from the current position of the disk head.
Because of being Scan algorithm it also executes all processes in the way.

**Comparison**

Let's see how would such algorithm work on our disk - we will test them on FCFS, as it is the worst algorithm for real time processes:

![Killed with real time shedulers](https://raw.githubusercontent.com/mmarusiak/mmarusiak.github.io/refs/heads/main/Posts/posts-materials/disk-sheduling/killedrt.png)

It's clear that FCFS with FD-Scan is the best algorithm for real time processes.
Because of no guarantee of executing processes in time and not executing processes in the way FCFS with EDF is the worst algorithm for real time processes, close to normal FCFS.

## CLOSING WORDS
In conclusion, disk scheduling algorithms play a crucial role in optimizing the performance of traditional HDDs by minimizing seek time and improving overall efficiency. While algorithms like FCFS are simple to implement, they often fall short in terms of performance compared to more advanced algorithms like SSTF, Scan, and C-Scan. Real-time processes introduce additional complexity, requiring specialized algorithms like EDF and FD-Scan to handle deadlines effectively. Understanding the strengths and weaknesses of each algorithm is essential for selecting the right approach based on specific use cases. As technology evolves and SSDs become more prevalent, the need for such algorithms may diminish, but their principles remain valuable for understanding how storage systems operate. Thank you for reading, and I hope this article provided valuable insights into the fascinating world of disk scheduling!
