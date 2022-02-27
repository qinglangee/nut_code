import java.util.ArrayList;

/**
 *
 * @author Mbassip2
 */
public class Othello {

    public static final int SQUARESIZE= 60;   // Basic dimensions of board
    public static final double PIECERATIO= 0.4; // ration of radius of piece to square size
    public static final int xBOARDpos= 100;   // Position of board
    public static final int yBOARDpos= 100;   // Position of board
    public static final int xMARGIN= 50;   // Position of board
    public static final int yMARGIN= 50;   // Position of board
    public static final int searchDepth= 8;   // Depth of minimax search
    

    
    
    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
       
        BoardState initialState= new BoardState();
        initialState.setContents(3, 3, 1);
        initialState.setContents(3, 4, -1);
        initialState.setContents(4, 3, -1);
        initialState.setContents(4, 4, 1);
        initialState.colour= -1;              // Black to start
        
        OthelloDisplay othelloDisplay= new OthelloDisplay();
        othelloDisplay.boardState= initialState;
        othelloDisplay.repaint();
    }
    
    
    
    public static Move chooseMove(BoardState boardState){

        ArrayList<Move> moves= boardState.getLegalMoves();
        if(moves.isEmpty())
            return null;
        // participant version: replace this line with the following code
	    // and provide the routines as directed in the lab exercise script.
        
        // return moves.get(0);
        return minimax(boardState, searchDepth);
    }

    private static Move minimax(BoardState boardState, int searchDepth){
        return MoveChooser.chooseMove(boardState, searchDepth);
    }
}
