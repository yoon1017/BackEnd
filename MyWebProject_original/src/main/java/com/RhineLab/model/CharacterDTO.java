package com.RhineLab.model;

import java.sql.Timestamp;
import java.util.*;

public class CharacterDTO {
    private int id;
    private String name;
    private int rarity;
    private List<String> tags;
    private Timestamp createdAt;
    
    public CharacterDTO() {
    }
    
    public CharacterDTO(int id, String name, int rarity, List<String> tags) {
        this.id = id;
        this.name = name;
        this.rarity = rarity;
        this.tags = tags;
    }
    
    public CharacterDTO(int id, String name, int rarity, List<String> tags, Timestamp createdAt) {
        this.id = id;
        this.name = name;
        this.rarity = rarity;
        this.tags = tags;
        this.createdAt = createdAt;
    }

    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public String getName() {
        return name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    public int getRarity() {
        return rarity;
    }
    
    public void setRarity(int rarity) {
        this.rarity = rarity;
    }
    
    public List<String> getTags() {
        return tags;
    }
    
    public void setTags(List<String> tags) {
        this.tags = tags;
    }
    
    public Timestamp getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return "CharacterDTO{" +
               "id=" + id +
               ", name='" + name + '\'' +
               ", rarity=" + rarity +
               ", tags=" + tags +
               ", createdAt=" + createdAt +
               '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        CharacterDTO that = (CharacterDTO) o;
        return id == that.id &&
               rarity == that.rarity &&
               Objects.equals(name, that.name) &&
               Objects.equals(tags, that.tags) &&
               Objects.equals(createdAt, that.createdAt);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, name, rarity, tags, createdAt);
    }
}