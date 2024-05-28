import java.util.Collection;
import java.util.LinkedList;
import java.util.List;
import java.util.Random;
import java.util.function.Consumer;
import java.util.function.Predicate;

public class ProbyZGenericsamiKlasamiLokalnymiWyrazeniamiLambda {
	
	static <T> void print(T object) {
		System.out.print(object);
		System.out.print(" ");
	}
	
	static <T> void println(T object) {
		System.out.print(object);
		System.out.println();
	}
	
	static <T> void println() {
		System.out.println();
	}
	
	// jak dzialaloby wypisywanie gdyby nazwa byla print(...) ?
	static <T> void printCollection(Collection<T> collection) {
		for(T e : collection) {
			ProbyZGenericsamiKlasamiLokalnymiWyrazeniamiLambda.print(e);
		}
		System.out.println();
	}
	
	static Random random = new Random();
	
	static Collection<Integer> randomIntList() {
		
		List<Integer> list = new LinkedList<>();
		
		for(int i = 0; i < 100; ++i) {
			list.add(ProbyZGenericsamiKlasamiLokalnymiWyrazeniamiLambda.random.nextInt(0, 1000));
		}
		
		return list;
	}
	
	/**********/
	
	<T> List<T> addToList(List<T> list, Collection<T> collection) {
		// czy mozna utworzyc element typu List<T> ?
		for(T e : collection) {
			list.add(e);
		}
		return list;
	}
	
	void aggregateOperations() {
		
		/* wypisanie liczb < 100 z listy losowych liczb na trzy sposoby */
		
		Collection<Integer> list = ProbyZGenericsamiKlasamiLokalnymiWyrazeniamiLambda.randomIntList();
		
		/* 1 */
		/* nazwane klasy lokalne */
		
		class Sprawdzacz implements Predicate<Integer> {

			@Override
			public boolean test(Integer t) {
				return t < 100;
			}
			
		}
		
		class Wypisywacz implements Consumer<Integer> {

			@Override
			public void accept(Integer t) {
				ProbyZGenericsamiKlasamiLokalnymiWyrazeniamiLambda.print(t);
			}
			
		}
		
		ProbyZGenericsamiKlasamiLokalnymiWyrazeniamiLambda.printCollection(list);
		list.stream().filter(new Sprawdzacz()).sorted().forEach(new Wypisywacz());
		ProbyZGenericsamiKlasamiLokalnymiWyrazeniamiLambda.println();
		
		/* 2 */
		/* anonimowe klasy lokalne i standardowe interfejsy funkcyjne */
		
		ProbyZGenericsamiKlasamiLokalnymiWyrazeniamiLambda.printCollection(list);
		list.stream().filter(new Predicate<Integer>() {

			@Override
			public boolean test(Integer t) {
				return t < 100;
			}
			
		}).sorted().forEach(new Consumer<Integer>() {

			@Override
			public void accept(Integer t) {
				ProbyZGenericsamiKlasamiLokalnymiWyrazeniamiLambda.print(t);
			}
			
		});
		ProbyZGenericsamiKlasamiLokalnymiWyrazeniamiLambda.println();
		
		/* 3 */
		/* wyrazenia lambda */
		
		ProbyZGenericsamiKlasamiLokalnymiWyrazeniamiLambda.printCollection(list);
		list.stream().filter(i -> i < 100).sorted().forEach(i -> ProbyZGenericsamiKlasamiLokalnymiWyrazeniamiLambda.print(i));
		ProbyZGenericsamiKlasamiLokalnymiWyrazeniamiLambda.println();
		
		/* koniec */
		
	}
	
	/* przetworzenie kolekcji liczb z jej dodatkowym wypisaniem */
	
	/* blad 1
	void consume(Collection<? extends Number> collection, Consumer<? extends Number> consumer) {
		for(Number n : collection) {
			ProbyZGenericsamiKlasamiLokalnymiWyrazeniamiLambda.print(n);
			consumer.accept(n);
		}
	}
	*/
	
	/* pelna zgodnosc typu
	<T extends Number> void consume(Collection<T> collection, Consumer<T> consumer) {
		for(T n : collection) {
			ProbyZGenericsamiKlasamiLokalnymiWyrazeniamiLambda.print(n);
			consumer.accept(n);
		}
	}
	*/
	
	/* ogolniej - consumer dowolnego typu akceptujacy T */
	
	<T extends Number> void consume(Collection<T> collection, Consumer<? super T> consumer) {
		for(T n : collection) {
			ProbyZGenericsamiKlasamiLokalnymiWyrazeniamiLambda.print(n);
			consumer.accept(n);
		}
	}
	
	public static void main(String[] args) {
		ProbyZGenericsamiKlasamiLokalnymiWyrazeniamiLambda tests = new ProbyZGenericsamiKlasamiLokalnymiWyrazeniamiLambda();
		tests.aggregateOperations();
	}
	

}
