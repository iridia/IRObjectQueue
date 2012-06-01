# IRObjectQueue

Simple object re-queueing like `UITableView`.

##	Usage

	IRObjectQueue *objectQueue = [IRObjectQueue new];
	[objectQueue addObject:anObject];	//	must conform to <IRQueueableObject> and return -reuseIdentifier
	
	//	Later
	[objectQueue dequeueObjectWithIdentifier:anIdentifier];
	
	//	When memory runs low
	[objectQueue removeAllObjects];

##	Authors

*	[Evadne Wu](http://radi.ws) at [Iridia Productions](http://iridia.tw) & [Waveface Inc.](http://waveface.com).