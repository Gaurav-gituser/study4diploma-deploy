package Model;
 public class Year {
    String year, year_id;

    @Override
    public String toString() {
        return "Year [year=" + year + ", yearId=" + year_id + "]";
    }

    public Year() {
        super();
    }

    public Year(String year, String year_id) {
        super();
        this.year = year;
        this.year_id = year_id;
    }

    public String getyear() {
        return year;
    }

    public void setyear(String year) {
        this.year = year;
    }

    public String getyear_id() {
        return year_id;
    }

    public void setyear_id(String year_id) {
        this.year_id = year_id;
    }
}
