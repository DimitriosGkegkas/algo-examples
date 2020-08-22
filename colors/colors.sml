fun colors file1= let
	fun read file =
		let
		(* A function to read an integer from specified input. *)
			fun readInt input = 
			Option.valOf (TextIO.scanStream (Int.scan StringCvt.DEC) input)

		(* Open input file. *)
			val inStream = TextIO.openIn file

			(* Read an integer (number of countries) and consume newline. *)
		val n = readInt inStream
		val col=readInt inStream
		val _ = TextIO.inputLine inStream

			(* A function to read N integers from the open file. *)
		fun readInts 0 acc = acc (* Replace with 'rev acc' for proper order. *)
		  | readInts i acc = readInts (i - 1) (readInt inStream :: acc)
		in
		((readInts n []),col,n)
		end
	;

	fun colorsMet ([],numColors,length)=0
	| colorsMet (l,numColors,length) = 
	let
		fun MAX(a,b)= if a<b then a else b;


		fun haveISeenYou ([], p)= false 
		|   haveISeenYou ((hd::tl), p)= if hd = p then true else haveISeenYou(tl, p);

		fun call  (l,l_map,dirty, seen,numColors,numSeenColors,length, d , max)= 
			if(length<=d) 
			then if numSeenColors=numColors then max else 0
			else
				if  (hd l_map=hd l) 
				then clean(tl l ,tl l_map, dirty ,seen ,numColors,numSeenColors,length -1 ,d,max)
				else
					if  (numSeenColors=numColors)
					then (
						Queue.enqueue(dirty,(hd l_map));
						call( l,tl l_map,dirty,seen, numColors,numSeenColors, length, d+1, max)
					)
					else 
						if haveISeenYou(seen,hd l_map)
						then ( 
							Queue.enqueue(dirty,(hd l_map));
							call( l,tl l_map,dirty,seen, numColors,numSeenColors, length, d+1, max)
						)
						else 
							if(numSeenColors+1=numColors) 
							then call(l, tl l_map, dirty, (hd l_map)::seen ,numColors,numSeenColors+1,length, d+1,MAX(max,d+1)) 
							else call(l, tl l_map, dirty, (hd l_map)::seen ,numColors,numSeenColors+1,length, d+1,max) 
		
		and clean(l,l_map,dirty, seen,numColors,numSeenColors,length, d , max) = 
		if (Queue.isEmpty dirty) 
		then  call(l,l_map,dirty,seen,numColors,numSeenColors,length,d,max )   
		else(
			if ((Queue.head dirty )= hd l  )
			then (  
				if (numColors= numSeenColors ) 
				then (
					Queue.dequeue dirty;
					clean (tl l,l_map, dirty ,seen,numColors,numSeenColors, length -1 ,d-1,MAX(max,d))
				) 
				else (
					Queue.dequeue dirty;
					clean (tl l,l_map,dirty ,seen,numColors,numSeenColors, length -1 ,d-1,(max) )
				)
			)
			else call(l,l_map, dirty,seen,numColors,numSeenColors,length,d,max )        
		)	
		
		
	in(
		call(l,tl l,Queue.mkQueue():int Queue.queue,[hd l],numColors,1,length , 1, length))
	end;

	fun test f =(
	if f([1 ,3,1, 3, 1 ,3 ,3 ,2 ,2,1],3,10) = 4 then print "ok!\n" else print "error\n";
	if f([2, 1, 4, 4, 4, 1, 1, 1, 4,3],4,10)=10 then print "ok!\n" else print "error\n";
	if f([1, 2, 2, 5, 1, 3, 1, 2, 1, 3],5,10)=0 then print "ok!\n" else print "error\n"
	);
	
in
(
print (Int.toString(colorsMet (read file1)));
print "\n"
)
end;

