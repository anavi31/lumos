package com.example.demo.model;

public enum Serie {
    _1, _2, _3;

    @Override
    public String toString() {
        // retorna '1','2','3' para bater com o banco se necessário
        return name().substring(1);
    }

    public static Serie fromDatabase(String value) {
        if (value == null) return null;
        switch (value) {
            case "1": return Serie._1;
            case "2": return Serie._2;
            case "3": return Serie._3;
            default: throw new IllegalArgumentException("Valor de série inválido: " + value);
        }
    }
}
