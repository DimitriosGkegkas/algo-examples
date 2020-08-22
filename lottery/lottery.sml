fun lottery File=
let

fun fastpower (x,0)=1
	|fastpower(x,n)= if n mod 2=0 then fastpower(x*x,n div 2)
	else x*fastpower(x*x,n div 2);

datatype 'a tree =empty 
	|root of ( 'a tree * 'a tree* 'a tree* 'a tree* 'a tree* 'a tree * 'a tree* 'a tree* 'a tree* 'a tree)
	|node of ('a * 'a * 'a tree * 'a tree* 'a tree* 'a tree* 'a tree* 'a tree * 'a tree* 'a tree* 'a tree* 'a tree);


	val trie=root(empty,empty,empty,empty,empty,empty,empty,empty,empty,empty)

	
fun insert([], T)=T
	|insert((H::T),empty)= 
						if null T then node(H, 0, empty,empty,empty,empty,empty,empty,empty,empty,empty,empty)
						else if (hd T) = 0 then node(H,1, insert(T,empty),empty,empty,empty,empty,empty,empty,empty,empty,empty)
						else if (hd T) = 1 then node(H,1,empty, insert(T,empty),empty,empty,empty,empty,empty,empty,empty,empty)
						else if (hd T) = 2 then node(H,1,empty, empty,insert(T,empty),empty,empty,empty,empty,empty,empty,empty)
						else if (hd T) = 3 then node(H,1,empty, empty,empty,insert(T,empty),empty,empty,empty,empty,empty,empty)
						else if (hd T)= 4 then node(H,1,empty, empty,empty,empty,insert(T,empty),empty,empty,empty,empty,empty)
						else if (hd T) = 5 then node(H,1,empty, empty,empty,empty,empty,insert(T,empty),empty,empty,empty,empty)
						else if (hd T) = 6 then node(H,1,empty, empty,empty,empty,empty,empty,insert(T,empty),empty,empty,empty)
						else if (hd T) = 7 then node(H,1,empty, empty,empty,empty,empty,empty,empty,insert(T,empty),empty,empty)
						else if (hd T) = 8 then node(H,1,empty, empty,empty,empty,empty,empty,empty,empty,insert(T,empty),empty)
						else  node(H,1,empty, empty,empty,empty,empty,empty,empty,empty,empty,insert(T,empty))

	|insert((H::T),node(h,k, T0,T1,T2,T3,T4,T5,T6,T7,T8,T9))=
						if null T then node(h, k,T0,T1,T2,T3,T4,T5,T6,T7,T8,T9)
						else if hd T = 0 then node(h, k+1,insert(T,T0),T1,T2,T3,T4,T5,T6,T7,T8,T9)
						else if hd T = 1 then node(h, k+1,T0,insert(T,T1),T2,T3,T4,T5,T6,T7,T8,T9)
						else if hd T = 2 then node(h,k+1, T0,T1,insert(T,T2),T3,T4,T5,T6,T7,T8,T9)
						else if hd T = 3 then node(h, k+1,T0,T1,T2,insert(T,T3),T4,T5,T6,T7,T8,T9)
						else if hd T = 4 then node(h,k+1, T0,T1,T2,T3,insert(T,T4),T5,T6,T7,T8,T9)
						else if hd T = 5 then node(h,k+1, T0,T1,T2,T3,T4,insert(T,T5),T6,T7,T8,T9)
						else if hd T = 6 then node(h, k+1,T0,T1,T2,T3,T4,T5,insert(T,T6),T7,T8,T9)
						else if hd T = 7 then node(h,k+1, T0,T1,T2,T3,T4,T5,T6,insert(T,T7),T8,T9)
						else if hd T = 8 then node(h,k+1, T0,T1,T2,T3,T4,T5,T6,T7,insert(T,T8),T9)
						else node(h,k+1, T0,T1,T2,T3,T4,T5,T6,T7,T8,insert(T,T9))
	|insert(T,root( T0,T1,T2,T3,T4,T5,T6,T7,T8,T9))=
						if null T then root(  T0,T1,T2,T3,T4,T5,T6,T7,T8,T9)
						else if hd T = 0 then root( insert(T,T0),T1,T2,T3,T4,T5,T6,T7,T8,T9)
						else if hd T = 1 then root( T0,insert(T,T1),T2,T3,T4,T5,T6,T7,T8,T9)
						else if hd T = 2 then root( T0,T1,insert(T,T2),T3,T4,T5,T6,T7,T8,T9)
						else if hd T = 3 then root( T0,T1,T2,insert(T,T3),T4,T5,T6,T7,T8,T9)
						else if hd T = 4 then root(  T0,T1,T2,T3,insert(T,T4),T5,T6,T7,T8,T9)
						else if hd T = 5 then root(  T0,T1,T2,T3,T4,insert(T,T5),T6,T7,T8,T9)
						else if hd T = 6 then root(  T0,T1,T2,T3,T4,T5,insert(T,T6),T7,T8,T9)
						else if hd T = 7 then root( T0,T1,T2,T3,T4,T5,T6,insert(T,T7),T8,T9)
						else if hd T = 8 then root(  T0,T1,T2,T3,T4,T5,T6,T7,insert(T,T8),T9)
						else root(  T0,T1,T2,T3,T4,T5,T6,T7,T8,insert(T,T9))

fun search([],T,Money,People,_)=[Money,People]
	|search(L,empty,Money,People,_)= [Money,People]
	|search((H::T),node(h,k, T0,T1,T2,T3,T4,T5,T6,T7,T8,T9),_,_,1)=
						if null T then [h, h]
						else if hd T = 0 then search(T,T0,k,k,2)
						else if hd T = 1 then search(T,T1,k,k,2)
						else if hd T = 2 then search(T,T2,k,k,2)
						else if hd T = 3 then search(T,T3,k,k,2)
						else if hd T = 4 then search(T,T4,k,k,2)
						else if hd T = 5 then search(T,T5,k,k,2)
						else if hd T = 6 then search(T,T6,k,k,2)
						else if hd T = 7 then search(T,T7,k,k,2)
						else if hd T = 8 then search(T,T8,k,k,2)
						else search(T,T9,k,k,2)
	|search((H::T),node(h,k, T0,T1,T2,T3,T4,T5,T6,T7,T8,T9),Money,People,Depth)=
						if null T then [Money+fastpower(2,Depth-1), People]
						else if hd T = 0 then search(T,T0,Money+k*(fastpower(2,Depth-1)),People,Depth+1)
						else if hd T = 1 then search(T,T1,Money+k*(fastpower(2,Depth-1)),People,Depth+1)
						else if hd T = 2 then search(T,T2,Money+k*(fastpower(2,Depth-1)),People,Depth+1)
						else if hd T = 3 then search(T,T3,Money+k*(fastpower(2,Depth-1)),People,Depth+1)
						else if hd T = 4 then search(T,T4,Money+k*(fastpower(2,Depth-1)),People,Depth+1)
						else if hd T = 5 then search(T,T5,Money+k*(fastpower(2,Depth-1)),People,Depth+1)
						else if hd T = 6 then search(T,T6,Money+k*(fastpower(2,Depth-1)),People,Depth+1)
						else if hd T = 7 then search(T,T7,Money+k*(fastpower(2,Depth-1)),People,Depth+1)
						else if hd T = 8 then search(T,T8,Money+k*(fastpower(2,Depth-1)),People,Depth+1)
						else search(T,T9,Money+k*(fastpower(2,Depth-1)),People,Depth+1)
		|search(T,root( T0,T1,T2,T3,T4,T5,T6,T7,T8,T9),_,_,_)=
						if null T then [0,0]
						else if hd T = 0 then search(T,T0,0,0,1)
						else if hd T = 1 then search(T,T1,0,0,1)
						else if hd T = 2 then search(T,T2,0,0,1)
						else if hd T = 3 then search(T,T3,0,0,1)
						else if hd T = 4 then search(T,T4,0,0,1)
						else if hd T = 5 then search(T,T5,0,0,1)
						else if hd T = 6 then search(T,T6,0,0,1)
						else if hd T = 7 then search(T,T7,0,0,1)
						else if hd T = 8 then search(T,T8,0,0,1)
						else search(T,T9,0,0,1)




	
		fun read infile=
		let
			fun readInt input = 
			Option.valOf (TextIO.scanStream (Int.scan StringCvt.DEC) input)

			val inStream = TextIO.openIn infile

			val K = readInt inStream
			val N=readInt inStream
			val Q=readInt inStream
			val _ = TextIO.inputLine inStream
		
			fun loop indata=
				case TextIO.inputLine indata of
					SOME line => List.tl(List.rev((map (fn x=>(ord x)-48 ) (String.explode line) )))::loop indata
				| 	NONE      => []
			
			val result = loop inStream
		in
			TextIO.closeIn inStream;
			(N,Q,result)
		end;
		

			
		fun importData (N, L)=
		let
			fun importData_help(0,_, tr)= tr
				|importData_help(n,(H::T), tr)=
					insert(H,importData_help(n-1,T,tr))
				|importData_help(n,[], tr)= tr
			val ro=trie
			val ro=importData_help(N,L,ro)
		in 
			ro
		end;
		
	fun solver(N,Q,data)=
	let
		val data_trie=importData(N,data)
	
		fun solution(_,[],tr, L)= L
			|solution(0,(H::T),tr,L)= solution(0,T,tr,(search(H,tr,0,0,0))::L)
			|solution(N,(H::T),tr,L)=  solution(N-1,T,tr,L)
	
	in
		solution(N,data,data_trie,[])
	end;
	
	fun print_s D =
		map (fn x=>( print( Int.toString(List.nth(x,1))); print " " ; print ( Int.toString(List.nth(x,0))) ; print "\n")) (List.rev D);
	
	
	
in 

	print_s(solver (read File))
	
end;
	


