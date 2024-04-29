try :
    raise Exception
except Exception :
    print("Złapałem wyjątek (1).")

try :
    try :
        raise ExceptionGroup(
            "G1",
            [
                Exception("numer 1"), Exception("numer 2"), SystemError("system error 1"),
                ExceptionGroup(
                    "G2",
                    [
                        Exception("numer 3"), Exception("numer 4"), SystemError("system error 2")
                    ]
                )
            ]
        )
    except* SystemError as e :
        print("Złapałem wyjątek (2) :")
        print(f'wyjątek: {type(e)}: e')
except* SystemError as e :
    print("Złapałem wyjątek (3) :")
    print(f'wyjątek: {type(e)}: e')
