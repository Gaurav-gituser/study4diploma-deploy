package Model;
 public class Branche {
    String branche, branche_id;

    @Override
    public String toString() {
        return "Branche [branche=" +branche  + ", branche_id=" +branche_id  + "]";
    }

    public Branche() {
        super();
    }

    public Branche(String branche, String branche_id) {
        super();
        this.branche = branche ;
        this.branche_id = branche_id;
    }

    public String getbranche() {
        return branche;
    }

    public void setbranche(String branche) {
        this.branche = branche;
    }

    public String getbranche_id() {
        return branche_id;
    }

    public void setbranche_id(String year_id) {
        this.branche_id = branche_id;
    }
}
