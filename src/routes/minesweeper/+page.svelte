<script lang="ts">
    const WIDTH: number = 8;
    const HEIGHT: number = 8;

    interface Mine {
        x: number;
        y: number;
        isFlagged: boolean;
        isMine: boolean;
        isRevealed: boolean;
        neighborMines: number;
    }
    
    let minesremaining = 0;
    let win = false;
    let gameOver = false;
    let board: Mine[] = initBoard(WIDTH, HEIGHT);

    function initBoard(w: number, h: number): Mine[] {
        gameOver = false;
        win = false;

        let cur: number = 0;
        let board: Mine[] = [];
        for (let i = 0; i < w; i++) {
            for (let j = 0; j < h; j++) {
                let mine: boolean = false;
                if ( Math.random() < 0.1 ) {
                    mine = true;
                    cur++;
                }
                board.push({
                    x: i,
                    y: j,
                    isFlagged: false,
                    isMine: mine,
                    isRevealed: false,
                    neighborMines: 0,
                });
            }
        }
        minesremaining = cur; 

        return board;
    }

    function revealCell(index: number): number {
        if (gameOver) return 0;

        let cell = board[index];

        if (cell.isRevealed || cell.isFlagged) return 1;

        if (cell.isRevealed || cell.isFlagged) return 0;

        if (board[index].isMine) {
            board[index].isRevealed = true;
            gameOver = true;
            return;
        }

        const isLeftEdge: boolean = index % WIDTH === 0;
        const isRightEdge: boolean = index % WIDTH === WIDTH - 1;
        const isTopEdge: boolean = index < WIDTH;
        const isBottomEdge: boolean = index >= WIDTH * (HEIGHT - 1);

        board[index].isRevealed = true; 

        let mines: number = 9;
        if (!isLeftEdge && !board[index - 1].isMine) {
            revealCell(index - 1);
            mines--;
        }
        if (!isRightEdge && board[index + 1].isMine) {
            revealCell(index + 1);
            mines--;
        }
        if (!isTopEdge && board[index - WIDTH].isMine) {
            revealCell(index - WIDTH);
            mines--;
        }
        if (!isBottomEdge && board[index + WIDTH].isMine) {
            revealCell(index + WIDTH);
            mines--;
        }
        if (
            !isTopEdge &&
            !isLeftEdge &&
            board[index - WIDTH - 1].isMine
        ) {
            revealCell(index - WIDTH - 1);
            mines--;
        }
        if (
            !isTopEdge &&
            !isRightEdge &&
            board[index - WIDTH + 1].isMine
        ) {
            revealCell(index - WIDTH + 1);
            mines--;
        }
        if (
            !isBottomEdge &&
            !isLeftEdge &&
            board[index + WIDTH - 1].isMine
        ) {
            revealCell(index + WIDTH - 1);
            mines--;
        }
        if (
            !isBottomEdge &&
            !isRightEdge &&
            board[index + WIDTH + 1].isMine
        ) {
            revealCell(index + WIDTH + 1);
            mines--;
        }
        cell.neighborMines = mines;
    }

    function restart() {
        board = initBoard(WIDTH, HEIGHT);
        gameOver = false;
        win = false;
    }

    function cellContent(cell: Mine): string {
        if (cell.isFlagged) return "🚩";
        else if (cell.isRevealed) return cell.neighborMines.toString();
        else return " ";
        // else if (cell.isRevealed && cell.isMine) return "💥";
        // else return "💣";
    }

    function toggleFlag(cell: Mine) {
        if (gameOver) return;
        if (cell.isRevealed) return; 
        else if (cell.isFlagged) {
            cell.isFlagged = false; 
            minesremaining++;
        } else { 
            cell.isFlagged = true;
            minesremaining--;
        }
    }
</script>

<div class="container">
    <h1>Minesweeper</h1>
    <div class="board">
        {#each board as cell, index}
            <button
                on:click={() => revealCell(index)}
                on:contextmenu={(_) => toggleFlag(cell)}
                disabled={gameOver}
            >
                {cellContent(cell)}
            </button>
            {#if (index + 1) % WIDTH === 0}
                <br />
            {/if}
        {/each}
    </div>
    <div class="info">
        <p>Flags remaining: {minesremaining}</p>
        <p>{gameOver ? "Game over!" : win ? "You win!" : " "}</p>
        <button class="reset" on:click={restart}>Restart</button>
    </div>
</div>


<style>
    button {
        width: 30px;
        height: 30px;
        border: 1px solid black;
        background-color: #ccc;
        font-size: 20px;
        padding: 0;
        margin: 0;
    }    
    .reset {
        margin-top: 10px;
        width: 100px;
    }
    .board {
        display: flex;
        flex-wrap: wrap;
        width: 240px;
    }
</style>
