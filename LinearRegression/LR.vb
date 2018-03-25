'ivansnpmaster
'25/03/2018

Public Class LR

    'y = ax + b
    Public a As Double
    Public b As Double

    'coeficiente de correlação
    Public r As Double
    'coeficiente de determinação [0, 1], a % da variação de y explicada pela reta ajustada
    Public r2 As Double

    'estimativa de y pela equação afim obtida
    Public ajuste() As Double
    '(real - ajuste)
    Public residuos() As Double

    Sub New(ByVal x_() As Double, ByVal y_() As Double)

        If Not (x_.Length = y_.Length) Then
            Return
        End If

        'somatória de elementos em x
        Dim Ex As Double = x_.Sum()
        'somatória de elementos em y
        Dim Ey As Double = y_.Sum()
        'somatória do produto de elementos com índice i dos arrays
        Dim Exy As Double = MultItemsInArrays(x_, y_)
        'somatória do quadrado dos elementos
        Dim Ex2 As Double = Sum2(x_)
        Dim Ey2 As Double = Sum2(y_)
        'médias de x e y
        Dim xm As Double = Ex / x_.Length
        Dim ym As Double = Ey / y_.Length
        'variâncias amostrais
        Dim s2x As Double = Ex2 - x_.Length * xm * xm
        Dim s2y As Double = Ey2 - y_.Length * ym * ym
        Dim s2xy As Double = Exy - x_.Length * xm * ym 'x_.Length = y_.Length

        r = s2xy / Math.Sqrt(s2x * s2y)
        r2 = r * r

        'estimativa de a
        a = s2xy / s2x
        'estimativa de b
        b = ym - a * xm

        ajuste = New Double(x_.Length - 1) {}
        residuos = New Double(x_.Length - 1) {}
        For i As Integer = 0 To x_.Length - 1
            ajuste(i) = a * x_(i) + b
            residuos(i) = y_(i) - ajuste(i)
        Next

    End Sub

    Private Function Sum2(ByVal lista() As Double) As Double
        Dim s As Double = 0
        For i As Integer = 0 To lista.Length - 1
            s += lista(i) * lista(i)
        Next
        Return s
    End Function

    Private Function MultItemsInArrays(ByVal a() As Double, ByVal b() As Double) As Double
        Dim s As Double = 0
        For i As Integer = 0 To a.Length - 1
            s += a(i) * b(i)
        Next
        Return s
    End Function

End Class