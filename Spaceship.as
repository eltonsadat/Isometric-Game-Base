package  {
	
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.ui.*;
		
	public class Spaceship extends MovieClip {		
		//Variáveis do movimento pelo teclado
		public var seta_cima:Boolean = false;
		public var seta_baixo:Boolean = false;
		public var seta_esq:Boolean = false;
		public var seta_dir:Boolean = false;
		public var tiro:Boolean = false
		
		//Variáveis de verificação se o tiro está no stage
		//e verificação se recebeu velocidade extra
		public var tiro_verif:Boolean = false
		public var tiroNoStage:Boolean = false;
		public var speedUP_verif:Boolean = false;
		
		//Variáveis de modificações de parâmetros do Hero
		public var velocidadeHero:int = 4;
		public var vidasHero:int = 3;
		public var pontos:int = 0;
		
		//Variável de pontuação mínima para uma nova vida
		public var cont:int = 100;
		
		//Variáveis dos Asteróides
		public var aster1_verif:Boolean = false;
		public var aster2_verif:Boolean = false;
		public var aster3_verif:Boolean = false;
		public var velocidadeAsteroide1:Number = 1 + Math.random()*10;
		public var velocidadeAsteroide2:Number = 1 + Math.random()*10;
		public var velocidadeAsteroide3:Number = 1 + Math.random()*10;
		
		//Variáveis dos Inimigos
		public var enemy1_verif:Boolean = false;
		public var enemy2_verif:Boolean = false;
		public var velocidadeEnemy1:Number = 1 + Math.random()*10;
		public var velocidadeEnemy2:Number = 1 + Math.random()*10;
		
		//Variáveis do Boss
		public var boss_verif:Boolean = false;
		public var vidasBoss:int = 2;
		public var vidaExtraBoss:int = 0;
		
		//Hero ganha vida extra a cada 100 pontos adquiridos
		public function vidaExtraHero(){
			if(pontos >= cont){
				vidasHero++;
				cont += 100;
			}
		}
		
		//Hero atira e verifica se o tiro está no Stage
		public function atirar(){
			projetil.y -= 15;
			if(tiro_verif && !tiroNoStage){
				projetil.x = hero.x;
				projetil.y = hero.y;
				tiro_verif = false;
				tiroNoStage = true;
			}else if(projetil.y - 15 <= 0){
				resetarProjetil();
			}
		}
		
		//Reinicia o projétil
		public function resetarProjetil(){
			projetil.x = 1000;
			projetil.y = 300;
			tiro_verif = false;
			tiroNoStage = false;
		}
		
		//Colisões entres os asteróides, inimigos e Boss
		public function colisao(){
			//Sincronizando posição das caixas de colisão aos seus elementos
			colisaoHero.x = hero.x;
			colisaoHero.y = hero.y;
			colisaoAsteroide1.x = asteroide1.x;
			colisaoAsteroide1.y = asteroide1.y;
			colisaoAsteroide2.x = asteroide2.x;
			colisaoAsteroide2.y = asteroide2.y;
			colisaoAsteroide3.x = asteroide3.x;
			colisaoAsteroide3.y = asteroide3.y;
			colisaoEnemy1.x = enemy1.x;
			colisaoEnemy1.y = enemy1.y;
			colisaoEnemy2.x = enemy2.x;
			colisaoEnemy2.y = enemy2.y;
			
			if(colisaoAsteroide1.hitTestObject(colisaoHero)){
			   aster1_verif = true;
			   hit.x = hero.x;
			   hit.y = hero.y;
			   hit.gotoAndPlay(2);
			   vidasHero--;
			}
			if(colisaoAsteroide2.hitTestObject(colisaoHero)){
			   aster2_verif = true;
			   hit.x = hero.x;
			   hit.y = hero.y;
			   hit.gotoAndPlay(2);
			   vidasHero--;
			}
			if(colisaoAsteroide3.hitTestObject(colisaoHero)){
			   aster3_verif = true;
			   hit.x = hero.x;
			   hit.y = hero.y;
			   hit.gotoAndPlay(2);
			   vidasHero--;
			}
			if(speedUP.hitTestObject(colisaoHero)){
				speedUP_verif = true;
				velocidadeHero++;
				pontos += 1;
				boost.gotoAndPlay(2);
			}
			if(colisaoEnemy1.hitTestObject(projetil)){
				enemy1_verif = true;
				pontos += 2;
				resetarProjetil();
				hitEnemy1.x = enemy1.x;
				hitEnemy1.y = enemy1.y;
				hitEnemy1.gotoAndPlay(2);
			}
			if(colisaoEnemy2.hitTestObject(projetil)){
				enemy2_verif = true;
				pontos += 2;
				resetarProjetil();
				hitEnemy2.x = enemy2.x;
				hitEnemy2.y = enemy2.y;
				hitEnemy2.gotoAndPlay(2);
			}
			if(boss.hitTestObject(projetil)){
				if(vidasBoss <= 0){
					boss_verif = true;
					pontos += 25;
					resetarProjetil();
					hitBoss.x = boss.x;
					hitBoss.y = boss.y + 100;
					hitBoss.gotoAndPlay(2);
				}else{
					vidasBoss--;
					pontos += 10;
					resetarProjetil();
					hitBoss.x = boss.x;
					hitBoss.y = boss.y + 100;
					hitBoss.gotoAndPlay(2);
				}
			}
			if(colisaoEnemy1.hitTestObject(colisaoHero)){
				enemy1_verif = true;
				vidasHero--;
				hitEnemy1.x = enemy1.x;
				hitEnemy1.y = enemy1.y;
				hitEnemy1.gotoAndPlay(2);
				hit.x = hero.x;
				hit.y = hero.y;
				hit.gotoAndPlay(2);
			}
			if(colisaoEnemy2.hitTestObject(colisaoHero)){
				enemy2_verif = true;
				vidasHero--;
				hitEnemy2.x = enemy2.x;
				hitEnemy2.y = enemy2.y;
				hitEnemy2.gotoAndPlay(2);
				hit.x = hero.x;
				hit.y = hero.y;
				hit.gotoAndPlay(2);
			}
			if(boss.hitTestObject(colisaoHero)){
				boss_verif = true;
				vidasHero -= 3;
				hitBoss.x = boss.x;
				hitBoss.y = boss.y + 100;
				hitBoss.gotoAndPlay(2);
				hit.x = hero.x;
				hit.y = hero.y;
				hit.gotoAndPlay(2);
			}
		}
		
		//Reiniciar os Asteróides
		public function resetarAsteroide(){
			if(aster1_verif){
				asteroide1.y = -50;
				asteroide1.x = Math.random()*stage.stageWidth;
				asteroide1.scaleX = 0.2 + Math.random()*2;
				asteroide1.scaleY = asteroide1.scaleX;
				colisaoAsteroide1.scaleX = asteroide1.scaleX;
				colisaoAsteroide1.scaleY = asteroide1.scaleY;
				velocidadeAsteroide1 = 1 + Math.random()*10;
				aster1_verif = false;
			}
			if(aster2_verif){
				asteroide2.y = -50;
				asteroide2.x = Math.random()*stage.stageWidth;
				asteroide2.scaleX = 0.2 + Math.random()*2;
				asteroide2.scaleY = asteroide2.scaleX;
				colisaoAsteroide2.scaleX = asteroide2.scaleX;
				colisaoAsteroide2.scaleY = asteroide2.scaleY;
				velocidadeAsteroide2 = 1 + Math.random()*10;
				aster2_verif = false;
			}
			if(aster3_verif){
				asteroide3.y = -50;
				asteroide3.x = Math.random()*stage.stageWidth;
				asteroide3.scaleX = 0.2 + Math.random()*2;
				asteroide3.scaleY = asteroide3.scaleX;
				colisaoAsteroide3.scaleX = asteroide3.scaleX;
				colisaoAsteroide3.scaleY = asteroide3.scaleY;
				velocidadeAsteroide3 = 1 + Math.random()*10;
				aster3_verif = false;
			}
		}
		
		//Reiniciar Inimigos
		public function resetarEnemy(){
			if(enemy1_verif){
				enemy1.y = -500;
				enemy1.x = Math.random()*stage.stageWidth;
				velocidadeEnemy1 = 1 + Math.random()*10;
				enemy1_verif = false;
			}
			if(enemy2_verif){
				enemy2.y = -1000;
				enemy2.x = Math.random()*stage.stageWidth;
				velocidadeEnemy2 = 1.5 + Math.random()*15;
				enemy2_verif = false;
			}
		}
		
		//Reiniciando o Boss
		public function resetarBoss(){
			if(boss_verif){
				boss.y = -3000;
				boss.x = 275;
				vidaExtraBoss++;
				vidasBoss = 2 + vidaExtraBoss;
				boss_verif = false;
			}
		}
		
		//Reiniciando o SpeedUP
		public function resetarSpeedUP(){
			if(speedUP_verif){
				speedUP.y = -2000 - Math.random()*3000;
				speedUP.x = Math.random()*stage.stageWidth;
				speedUP_verif = false;
			}
		}
		
		//Atualizando HUD de Vidas
		public function mostrarVidas(){
			vidasUI.text = String(vidasHero);
		}
		
		//Atualizando HUD de Velocidade
		public function mostrarVelocidade(){
			velocidadeUI.text = String(velocidadeHero - 3);
		}
		
		//Atualizando HUD de Scores
		public function mostrarPontos(){
			pontosUI.text = String(pontos);
		}
		
		//Fim do Jogo
		public function gameOver(){
			//Reiniciando todas as variáveis
			seta_cima = false;
			seta_baixo = false;
			seta_esq = false;
			seta_dir = false;
			tiro = false;
			tiro_verif = false
			tiroNoStage = false;
			velocidadeHero = 4;
			vidasHero = 3;
			pontos = 0;
			cont =100;
			speedUP_verif = false;
			aster1_verif = false;
			aster2_verif = false;
			aster3_verif = false;
			velocidadeAsteroide1 = 1 + Math.random()*10;
			velocidadeAsteroide2 = 1 + Math.random()*10;
			velocidadeAsteroide3 = 1 + Math.random()*10;
			enemy1_verif = false;
			enemy2_verif = false;
			velocidadeEnemy1 = 1 + Math.random()*10;
			velocidadeEnemy2 = 1 + Math.random()*10;
			boss_verif = false;
			vidasBoss = 3;
			vidaExtraBoss = 0;
			
			//Removendo os Eventos
			this.removeEventListener(Event.ENTER_FRAME,gameLoop);
			stage.removeEventListener(KeyboardEvent.KEY_DOWN,pressionando);
			stage.removeEventListener(KeyboardEvent.KEY_UP,soltando);
			nextFrame();
		}
		
		//Pressionando os botões
		public function pressionando(event:KeyboardEvent){
			switch (event.keyCode){
				case Keyboard.UP:
					seta_cima = true;
					break;
				case Keyboard.DOWN:
					seta_baixo = true;
					break;
				case Keyboard.LEFT:
					seta_esq = true;
					break;
				case Keyboard.RIGHT:
					seta_dir = true;
					break;
				case Keyboard.SPACE:
					tiro = true;
					break;
			}
		}
		
		//Soltando os botões
		public function soltando(event:KeyboardEvent){
			switch (event.keyCode){
				case Keyboard.UP:
					seta_cima = false;
					break;
				case Keyboard.DOWN:
					seta_baixo = false;
					break;
				case Keyboard.LEFT:
					seta_esq = false;
					break;
				case Keyboard.RIGHT:
					seta_dir = false;
					break;
				case Keyboard.SPACE:
					tiro = false;
					break;
			}
		}
		
		//Função constante do Game
		public function gameLoop(event:Event){
			//Adicionando as funções
			mostrarVidas();
			mostrarPontos();
			mostrarVelocidade();			
			colisao();
			atirar();
			vidaExtraHero();
			resetarAsteroide();
			resetarSpeedUP();
			resetarEnemy();
			resetarBoss();
			
			//Aplicando velocidade 
			asteroide1.y += velocidadeAsteroide1;
			asteroide2.y += velocidadeAsteroide2;
			asteroide3.y += velocidadeAsteroide3;
			enemy1.y += velocidadeEnemy1;
			enemy2.y += velocidadeEnemy2;
			boss.y += 1;
			speedUP.y += 4;
			
			//Posição do Efeito do SpeedUP
			boost.x = hero.x;
			boost.y = hero.y - 27.275;
			
			//Caso elementos saiam do Stage
			if(asteroide1.y >= stage.stageHeight + 50){
				aster1_verif = true;
			}
			if(asteroide2.y >= stage.stageHeight + 50){
				aster2_verif = true;
			}
			if(asteroide3.y >= stage.stageHeight + 50){
				aster3_verif = true;
			}
			if(speedUP.y >= stage.stageHeight + 25){
				speedUP_verif = true;
			}
			if(enemy1.y >= stage.stageHeight + 100){
				enemy1_verif = true;
			}
			if(enemy2.y >= stage.stageHeight + 150){
				enemy2_verif = true;
			}
			if(boss.y >= stage.stageHeight + 135.85){
				boss_verif = true;
			}
			
			//Game Over se ficar sem vidas
			if(vidasHero < 0){
				gameOver();
			}
			
			//Declarando o que faz cada tecla do teclado
			if(seta_cima){
				if(hero.y - 27.275 <= 0){
					//Faz nada, pois assim não sai do Stage
				}else{
					hero.y -= velocidadeHero;
					hero.gotoAndStop("voando");
				}
			}
			if(seta_baixo){
				if(hero.y + 27.275  >= stage.stageHeight){
					//Faz nada, pois assim não sai do Stage
				}else{
					hero.y += velocidadeHero;
					hero.gotoAndStop("re");
				}
			}
			if(seta_esq){
				if(hero.x - 24.525 <= 0){
					//Faz nada, pois assim não sai do Stage
				}else{
					hero.x -= velocidadeHero;
					hero.gotoAndStop("virando");
					hero.scaleX = -1;
				}
			}
			if(seta_dir){
				if(hero.x + 24.525 >= stage.stageWidth){
					//Faz nada, pois assim não sai do Stage
				}else{
					hero.x += velocidadeHero;
					hero.gotoAndStop("virando");
					hero.scaleX = 1;
				}
			}
			if(tiro){
				tiro_verif = true;
			}
			//Declarando o que acontece caso não pressione nada
			if(!seta_cima && !seta_baixo && !seta_esq && !seta_dir){
				hero.gotoAndStop("parado");
				if(hero.y + 27.275 >= stage.stageHeight){
					//Faz nada, pois assim não sai do Stage
				}else{
					//Gravidade
					hero.y += 1;
				}
			}
		}
		
		//Iniciando o Game!
		public function startGame(){
			boss.y = -3000;
			stage.addEventListener(KeyboardEvent.KEY_DOWN, pressionando);
			stage.addEventListener(KeyboardEvent.KEY_UP, soltando);
			this.addEventListener(Event.ENTER_FRAME, gameLoop);
		}
	}
	
}
