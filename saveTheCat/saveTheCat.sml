
fun savethecat data=
let
		fun read infile=
		let 	
			val ins=TextIO.openIn infile
			fun loop indata=
				case TextIO.inputLine indata of
					SOME line => (String.explode line) ::loop indata
				| 	NONE      => []
			val result = loop ins
		in
			TextIO.closeIn ins;
			result
		end;
		
		fun together infile= 
		let
			val arr= Array2.fromList (read infile)
		in 
			(arr,Array2.nRows arr,Array2.nCols arr)
		end;


		fun fload(array:char Array2.array,N,M)=
		let
			fun fload_help(array,array_fload,N,M,i,j,time)=(
				if Array2.sub(array_fload, i,j)>time 
				then 
					if(Array2.sub(array, i,j)= #"X") 
					then () 
					else (
						Array2.update (array_fload, i, j, time);
						if(i+1<N) then fload_help(array,array_fload,N,M,i+1,j,time+1) else ();
						if(i-1>=0) then fload_help(array,array_fload,N,M,i-1,j,time+1) else ();
						if(j+1<M) then fload_help(array,array_fload,N,M,i,j+1,time+1) else ();
						if(j-1>=0) then fload_help(array,array_fload,N,M,i,j-1,time+1) else ()
				)
				else ()
			)

			fun cat_help(array,array_cat,array_moves,moves,N,M,i,j,time)=(
				if Array2.sub(array_cat, i,j) >time 
				then 
					if(Array2.sub(array, i,j)= #"X") 
					then () 
					else (
						Array2.update (array_cat, i, j, time); 
						Array2.update (array_moves, i, j, moves);
						if(j-1>=0) then cat_help(array,array_cat,array_moves,"L"::moves,N,M,i,j-1,time+1) else ();
						if(i-1>=0) then cat_help(array,array_cat,array_moves,"U"::moves,N,M,i-1,j,time+1) else ();
						if(j+1<M) then cat_help(array,array_cat,array_moves,"R"::moves,N,M,i,j+1,time+1) else ();
						if(i+1<N) then cat_help(array,array_cat,array_moves,"D"::moves,N,M,i+1,j,time+1) else ()
				)
				else ()
			)
			
			fun find_pipes_and_cat (array_fload,array_cat,array_moves,array:char Array2.array,i,j,N,M)= (
				if (Array2.sub(array, i,j)= #"W") 
				then fload_help(array,array_fload,N,M,i,j,0) 
				else if (Array2.sub(array, i,j)= #"A") 
				then cat_help(array,array_cat,array_moves,[],N,M,i,j,0) 
				else();

				if(j+1=M) 
				then (
					if(i+1=N) 
					then (array_fload,array_cat,array_moves,N,M) 
					else find_pipes_and_cat(array_fload,array_cat,array_moves,array,i+1,0,N,M)
					)
				else find_pipes_and_cat(array_fload,array_cat,array_moves,array,i,j+1,N,M)
			)

			fun solver(array_fload,array_cat,array_moves:string list Array2.array,N,M)=
			let
				fun solver_help(array_fload,array_cat,array_moves:string list Array2.array,N,M,i,j,maxI,maxJ,maxTime)=(
					if( Array2.sub(array_fload, i,j)>maxTime) 
					then( 
						if (Array2.sub(array_fload, i,j)>Array2.sub(array_cat, i,j)) 
						then (
							if(j+1=M) 
							then (
								if(i+1=N) 
								then (Array2.sub(array_fload, i,j),Array2.sub(array_moves, i,j),N,M) 
								else solver_help(array_fload,array_cat,array_moves,N,M,i+1,0,i,j,Array2.sub(array_fload, i,j))
								) 
							else solver_help(array_fload,array_cat,array_moves,N,M,i,j+1,i,j,Array2.sub(array_fload, i,j))
							)
						else (
							if(j+1=M) 
							then (
								if(i+1=N) 
								then (Array2.sub(array_fload, maxI,maxJ)-1,Array2.sub(array_moves, maxI,maxJ),N,M)
								else solver_help(array_fload,array_cat,array_moves,N,M,i+1,0,maxI,maxJ,maxTime)
							)
							else solver_help(array_fload,array_cat,array_moves,N,M,i,j+1,maxI,maxJ,maxTime)
						)
					)
					else (
						if(j+1=M) 
						then (
							if(i+1=N) 
							then (Array2.sub(array_fload, maxI,maxJ)-1,Array2.sub(array_moves, maxI,maxJ),N,M)
							else solver_help(array_fload,array_cat,array_moves,N,M,i+1,0,maxI,maxJ,maxTime)
						)
						else solver_help(array_fload,array_cat,array_moves,N,M,i,j+1,maxI,maxJ,maxTime)
					)
				)
			in
				solver_help(array_fload,array_cat,array_moves,N,M,0,0,0,0,0)
			end;
									
		in
			solver (find_pipes_and_cat(Array2.array (N, M, N*M),Array2.array (N, M, N*M),Array2.array (N, M, []),array,0,0,N,M))
		end;
		
		fun print_sol (num, root, N,M)=(
		if(num >=N*(M-1)) then print "infinity" else print (Int.toString(num));
		print "\n";
		if(null root) then print "stay" else ();
		map (fn x=>print ( (x)) ) (rev root);
		print "\n"
		)
		
in

	print_sol (fload (together data))
	
end;



