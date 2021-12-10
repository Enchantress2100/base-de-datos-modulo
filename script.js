//primer ejercicio, tabla de multiplicar
function multiplicar(numero) {

    console.log(`Tabla de multiplicar del ${numero}`)
    for (i = 1; i <= 10; i++){
        resultado= i*numero
        console.log(`${i} * ${numero} = ${resultado} `)
    }
    
}
multiplicar(6)


//segundo ejercicio, comprobar si el string es un palindromo
function palindrome(str) {
let dividirStr = str.split('').reverse().join('')
    if (str === dividirStr) {
        console.log('es palindromo')
    } else {
        console.log('no es palindromo')
    }
}
palindrome('hola')


//tercer ejercicio, buscar palabra en una frase, hacer un mapa asignando un valor a cada palabra, y devolver las coincidencias
function repeticion(frase, busqueda) {
    let minusculasLimpio = frase.toLowerCase().replace(/[&\/\\#^+()$~%.'":*?<>{}!@]/g, '')
    let resultado = 0
    if (minusculasLimpio.includes(busqueda)) {
        let palabras = minusculasLimpio.split(' ')
        let mapa = {}
        for (let palabra of palabras) {
            if (mapa[palabra]) {
                mapa [palabra]++
            } else {
                mapa[palabra]=1
            }
            resultado=mapa[busqueda]
            }       
    } else { resultado=0
    }
    return resultado
    }
console.log('Coincidencias : ', repeticion('me llamo Luna %&$ luna', 'hola'))

//cuarto ejercicio, dado un string, darle la vuelta e invertir el orden de sus caracteres solo usando estructuras de control

function palabra(texto) {
    let invertir = '';
    for (let letra of texto){
        invertir=letra +invertir //asi damos vuelta el string
    }
    return invertir
}
console.log('texto invertido: ', palabra('lila'))
