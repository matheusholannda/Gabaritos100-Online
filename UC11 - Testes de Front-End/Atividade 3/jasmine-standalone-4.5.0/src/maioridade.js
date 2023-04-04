const maioridade = function(idade){

    if(idade <=0){
        return 'Idade Inválida';
    }

    if(idade>=18){
        return 'Maior Idade';
    }else{
        return 'Menor Idade';
    }
}
