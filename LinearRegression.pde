//Agradecimento especial ao canal giant_neural_network

// Flores conhecidas (0 -> Azul, 1 -> Vermelha)
float[][] data = {
  {3.0, 1.5, 1.0}, 
  {2.0, 1.0, 0.0}, 
  {4.0, 1.5, 1.0}, 
  {3.0, 1.0, 0.0}, 
  {3.5, 0.5, 1.0}, 
  {2.0, 0.5, 0.0}, 
  {5.5, 1.0, 1.0}, 
  {1.0, 1.0, 0.0}
};
// Flor a ser classificada
float[] florMisteriosa = {4.5, 1.0};
// Pesos e bias
float w1, w2, b;
// Fração da taxa de variação dos pesos e bias
float velocidadeAprendizado = 0.2;
// Para fins de visualização
int escala = 50;
// Loops por loop do programa
int loopsDeTreino = 100;

void setup()
{
  size(400, 400);

  w1 = random(0, 1) * 2 - 1;
  w2 = random(0, 1) * 2 - 1;
  b = random(0, 1) * 2 - 1;
}

void draw()
{
  for (int k = 0; k < loopsDeTreino; k++)
    Treinar();

  DesenharDados();

  float predicao = sigmoid(florMisteriosa[0] * w1 + florMisteriosa[1] * w2 + b);
  int cor = round(predicao);

  if (cor == 1)
    stroke(255, 0, 0);
  else
    stroke(0, 0, 255);

  point(florMisteriosa[0] * escala, -florMisteriosa[1] * escala);
}

// Função de ativação sigmóide
float sigmoid(float x)
{
  return 1 / (1 + exp(-x));
}

// Derivada da função de ativação
float sigmoid_p(float x)
{
  return sigmoid(x) * (1 - sigmoid(x));
}

void Treinar()
{
  // Índice randômico
  int ri = floor(random(data.length));
  // Flor baseada no índice randômico
  float[] f = data[ri];
  float z = w1 * f[0] + w2 * f[1] + b;
  float predicao = sigmoid(z);
  
  // Quadrado do erro/custo, para fins de análise
  // float custo_2 = pow(pred - rf[2], 2);

  // Regra da cadeia
  // Variação do custo em relação ao predito
  float dcost_pred = 2 * (predicao - f[2]);
  // Variação do predito em relação ao z
  float dpred_dz = sigmoid_p(z);
  // Variação de z em relação ao w1
  float dz_dw1 = f[0];
  // Variação de z em relação ao w2
  float dz_dw2 = f[1];
  // Variação de z em relação ao bias
  float dz_db = 1.0;

  float dcost_dz = dcost_pred * dpred_dz;
  // Aplicando a regra da cadeia em derivadas parciais para cada variável
  float dcost_dw1 = dcost_dz * dz_dw1;
  float dcost_dw2 = dcost_dz * dz_dw2;
  float dcost_db = dcost_dz * dz_db;

  // Diminuindo de cada variável uma fração de sua variação
  // Se não subtrair, estará indo na direção de máximo do gráfico
  w1 -= velocidadeAprendizado * dcost_dw1;
  w2 -= velocidadeAprendizado * dcost_dw2;
  b -= velocidadeAprendizado * dcost_db;
}

void DesenharDados()
{
  background(0, 150, 90);
  translate(0, height);

  stroke(255);
  strokeWeight(1);
  // Eixos X e Y
  line(0, 0, 0, -height);
  line(0, 0, width, 0);

  strokeWeight(5);

  for (int i = 0; i < data.length; i++)
  {
    if (data[i][2] < 0.5)
      stroke(0, 0, 255);
    else
      stroke(255, 0, 0);
    point(data[i][0] * escala, -data[i][1] * escala);
  }
}
