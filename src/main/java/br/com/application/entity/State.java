package br.com.application.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlType;

import com.fasterxml.jackson.annotation.JsonIgnore;

import br.com.application.response.Message;

@Entity
@Table(name = "state")
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "State", propOrder = {
        "id",
        "stateName",
        "country",
        "message"
}, namespace = "http://invviteme.com/domain")
public class State {
	
	@Id
    @GeneratedValue
    @JsonIgnore
	private Integer id;
	
    @Column(name = "statename")
	private String stateName;
    
    @Column(name = "country")
	private String country;

    @Transient
    private Message message;
    
    /**
	 * Default Constructor only use JacksonMapper
	 */
    public State(){}
    
	public State(String stateName, String country) {
		this.stateName = stateName;
		this.country = country;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getStateName() {
		return stateName;
	}

	public String getCountry() {
		return country;
	}
	
	public void setMessage(Message message) {
		this.message = message;
	}
	
	public Message getMessage() {
		return message;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((country == null) ? 0 : country.hashCode());
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		result = prime * result
				+ ((stateName == null) ? 0 : stateName.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		State other = (State) obj;
		if (country == null) {
			if (other.country != null)
				return false;
		} else if (!country.equals(other.country))
			return false;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		if (stateName == null) {
			if (other.stateName != null)
				return false;
		} else if (!stateName.equals(other.stateName))
			return false;
		return true;
	}

    @Override
    public String toString() {
        return "State [id=" + id + ", stateName=" + stateName + ", country=" + country + "]";
    }
}
